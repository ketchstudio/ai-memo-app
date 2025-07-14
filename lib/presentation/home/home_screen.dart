import 'package:ana_flutter/presentation/home/create_from_text/create_from_text.dart';
import 'package:ana_flutter/presentation/home/home_main_action.dart';
import 'package:ana_flutter/presentation/home/search_bar.dart';
import 'package:ana_flutter/presentation/login/bloc/auth_bloc.dart';
import 'package:ana_flutter/presentation/routers/app_router_contract.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../app/bloc/folder/folder_bloc.dart';
import '../app/bloc/folder/folder_state.dart';
import '../app/bloc/theme_cubit.dart';
import 'action/note_create_option_bottomsheet.dart';
import 'folder/folder_card.dart';
import 'folder/folder_contract.dart';
import 'home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder for the main content area
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SearchBarWidget(
                    controller: TextEditingController(),
                    onChanged: (query) {
                      // Handle search action
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Folders',
                    style: AppTextStyles.titleLarge(
                      context,
                    ).withFontWeight(FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BlocBuilder<FolderBloc, FolderState>(
                        builder: (context, state) {
                          if (state is FolderLoading) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (state is FolderFailure) {
                            return Center(child: Text(state.message));
                          }
                          if (state is FolderLoadSuccess) {
                            final folderUiItems = state.folders
                                .map((e) => e.toUiItem())
                                .toList();
                            return Row(
                              children: folderUiItems
                                  .map(
                                    (item) => FolderCard(
                                      folder: item,
                                      onFolderSelected: (_) {},
                                    ),
                                  )
                                  .toList(),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: HomeMainAction(
                onAddTap: () =>
                    showNoteCreateOptionBottomSheet(context, (option) {
                      showCreateTextNoteDialog(context);
                    }),
                onMindMapTap: () => context.push(AppRoute.mindMap.path),
                onExploreTap: () => context.push(AppRoute.explore.path),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
