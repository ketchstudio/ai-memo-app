import 'package:ana_flutter/presentation/app/bloc/folder/folder_event.dart';
import 'package:ana_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:ana_flutter/presentation/home/create_from_text/create_from_text.dart';
import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:ana_flutter/presentation/home/home_main_action.dart';
import 'package:ana_flutter/presentation/home/search_bar.dart';
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
import 'action/note_create_option_bottomsheet.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: RefreshIndicator(
                  onRefresh: () async {
                    print('Refreshing folders and notes...');
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
                                  if (state is FolderLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (state is FolderLoadSuccess &&
                                      state.folders.isEmpty) {
                                    return const Center(
                                      child: Text('No folders available'),
                                    );
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
                              BlocConsumer<HomeBloc, HomeState>(
                                listener: (context, state) {
                                  print(
                                    'Selected folder: ${state.selectedFolderId}',
                                  );
                                },
                                builder: (context, state) =>
                                    NotesList(notes: state.notes),
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
                        showCreateTextNoteDialog(context);
                      });
                    },
                    onMindMapTap: () => context.push(AppRoute.mindMap.path),
                    onExploreTap: () => context.push(AppRoute.explore.path),
                  ),
                ),
              ),
            ],
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
      folders: [
        FolderUiItem(
          id: HomeConstant.allNotesFolderId,
          name: "All Notes",
          noteCount: folders.fold(0, (sum, folder) => sum + folder.noteCount),
          type: FolderType.all,
        ),
        ...folders,
      ],
      onFolderSelected: onFolderSelected,
    ),
  );
}
