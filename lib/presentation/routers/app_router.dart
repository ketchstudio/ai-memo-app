import 'package:ana_flutter/presentation/folder_management/folder_management_screen.dart';
import 'package:go_router/go_router.dart';

import '../create_folder/create_folder_screen.dart';
import '../edit_memo/edit_memo_screen.dart';
import '../explore/explore_screen.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';
import '../memo_detail/memo_detail_screen.dart';
import '../mindmap/mind_map_screen.dart';
import '../settings/settings_screen.dart';
import '../translate/translate_screen.dart';

class AppRouter {
  final bool isAuth;
  late final GoRouter router;

  AppRouter({required this.isAuth}) {
    router = GoRouter(
      initialLocation: '/home',
      redirect: (context, state) {
        final loggingIn = state.path == '/login';
        if (!isAuth && !loggingIn) return '/login';
        if (isAuth && loggingIn) return '/home';
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (_, _) => const LoginScreen(), // replace with LoginScreen
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (_, _) => const HomeScreen(),
        ),
        GoRoute(
          path: '/create-folder',
          name: 'createFolder',
          builder: (_, _) => const CreateFolderScreen(),
        ),
        GoRoute(
          path: '/edit-memo',
          name: 'editMemo',
          builder: (_, _) => const EditMemoScreen(),
        ),
        GoRoute(
          path: '/memo-detail',
          name: 'memoDetail',
          builder: (_, _) => const MemoDetailScreen(),
        ),
        GoRoute(
          path: '/mind-map',
          name: 'mindMap',
          builder: (_, _) => const MindMapScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (_, _) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/translate',
          name: 'translate',
          builder: (_, _) => const TranslateScreen(),
        ),
        GoRoute(
          path: '/explore',
          name: 'explore',
          builder: (_, _) => const ExploreScreen(),
        ),
        GoRoute(
          path: '/folder-management',
          name: 'folderManagement',
          builder: (_, _) => const FolderManagementScreen(),
        ),
      ],
    );
  }
}
