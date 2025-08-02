import 'package:ana_flutter/core/presentation/snackbar_manager.dart';
import 'package:ana_flutter/di/service_locator.dart';
import 'package:ana_flutter/presentation/app/bloc/folder/folder_event.dart';
import 'package:ana_flutter/presentation/home/action/note_create_option.dart';
import 'package:ana_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:ana_flutter/presentation/home/create_from_text/create_from_text.dart';
import 'package:ana_flutter/presentation/home/create_from_youtube/create_youtube_note.dart';
import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:ana_flutter/presentation/home/home_main_action.dart';
import 'package:ana_flutter/presentation/home/search_bar.dart';
import 'package:ana_flutter/presentation/home/voice_recording/voice_recording.dart';
import 'package:ana_flutter/presentation/login/bloc/auth_bloc.dart';
import 'package:ana_flutter/presentation/routers/app_router_contract.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/folder.dart';
import '../app/bloc/folder/folder_bloc.dart';
import '../app/bloc/folder/folder_state.dart';
import '../app/bloc/theme_cubit.dart';
import '../di/popup/ui_service.dart';
import 'action/note_create_option_bottomsheet.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';
import 'common/file_picker_with_preview.dart';
import 'folder/folder_list_view.dart';
import 'home_app_bar.dart';
import 'note/note_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        isDarkMode: context.read<ThemeCubit>().state == ThemeMode.dark,
        onSettingsPressed: () => context.push(AppRoute.settings.path),
        onModeChanged: () => context.read<ThemeCubit>().toggleTheme(),
        onLogoutPressed: () =>
            context.read<AuthBloc>().add(AuthLogoutRequested()),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _homeBloc,
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeNoteDeleted) {
                SnackbarManager.show(message: 'Note deleted successfully');
              }

              if (state is HomeError) {
                getIt<UiService>().showErrorDialog(
                  context: context,
                  error: state.error,
                  onRetry: () async {
                    print('Retrying to refresh folders and notes');
                    context.read<FolderBloc>().add(RefreshFolders());
                    _homeBloc.add(HomeRefresh());
                    await context.read<FolderBloc>().stream.firstWhere(
                      (state) => state is! FolderLoading,
                    );
                  },
                );
              }
            },
            builder: (context, homeState) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<FolderBloc>().add(RefreshFolders());
                        _homeBloc.add(HomeRefresh());
                        await context.read<FolderBloc>().stream.firstWhere(
                          (state) => state is! FolderLoading,
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: SearchBarWidget(
                              controller: TextEditingController(),
                              onChanged: (query) {
                                // Handle search action
                              },
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Folders',
                                          style: AppTextStyles.titleLarge(
                                            context,
                                          ).withFontWeight(FontWeight.bold),
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'Manage',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          onPressed: () => context.push(
                                            AppRoute.folderManagement.path,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  BlocBuilder<FolderBloc, FolderState>(
                                    builder: (context, state) {
                                      if (state is FolderLoadSuccess &&
                                          state.folders.isEmpty) {
                                        return const Center(
                                          child: Text('No folders available'),
                                        );
                                      }

                                      if (state is FolderLoading) {
                                        return SizedBox.shrink();
                                      }
                                      return _content(context, state.folders, (
                                        folderId,
                                      ) {
                                        context.read<HomeBloc>().add(
                                          HomeSelectFolder(folderId),
                                        );
                                      });
                                    },
                                  ),
                                  BlocConsumer<FolderBloc, FolderState>(
                                    listener: (context, state) {
                                      if (state is FolderFailure) {
                                        getIt<UiService>().showErrorDialog(
                                          context: context,
                                          error: state.appError,
                                          onRetry: () {
                                            context.read<FolderBloc>().add(
                                              RefreshFolders(),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is FolderLoading) {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 20,
                                            ),
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      } else {
                                        if (homeState.notes.isEmpty &&
                                            homeState is HomeRefreshing) {
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 20,
                                              ),
                                              child: Text('No notes available'),
                                            ),
                                          );
                                        } else {
                                          return NotesList(
                                            notes: homeState.notes,
                                            onDelete: (id, folderId) =>
                                                _homeBloc.add(
                                                  HomeDeleteNote(id, folderId),
                                                ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 60),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: HomeMainAction(
                        onAddTap: () {
                          showNoteCreateOptionBottomSheet(context, (option) {
                            switch (option) {
                              case NoteOption.text:
                                showCreateTextNoteDialog(context);
                              case NoteOption.youtube:
                                showCreateYoutubeNoteDialog(context);
                              case NoteOption.recordAudio:
                                showVoiceRecorderDialog(context);
                              case NoteOption.documentFile:
                                pickAndShowPreview(
                                  context,
                                  AppFileType.document,
                                );
                              case NoteOption.uploadImage:
                                pickAndShowPreview(context, AppFileType.image);
                            }
                          });
                        },
                        onMindMapTap: () => context.push(AppRoute.mindMap.path),
                        onExploreTap: () => context.push(AppRoute.explore.path),
                      ),
                    ),
                  ),

                  if (homeState is HomeRefreshing ||
                      homeState is HomeNoteLoading ||
                      homeState is HomeNoteDeleting)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _content(
  BuildContext context,
  List<FolderUiItem> folders,
  Function(String folderId) onFolderSelected,
) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: FolderListView(
      folders: folders.length <= 1
          ? []
          : [
              FolderUiItem(
                id: HomeConstant.allNotesFolderId,
                name: "All Notes",
                noteCount: folders.fold(
                  0,
                  (sum, folder) => sum + folder.noteCount,
                ),
                type: FolderType.all,
              ),
              ...folders,
            ],
      onFolderSelected: onFolderSelected,
    ),
  );
}
