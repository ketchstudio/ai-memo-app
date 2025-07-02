import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../create_folder/create_folder_screen.dart';
import '../edit_memo/edit_memo_screen.dart';
import '../home/home_screen.dart';
import '../memo_detail/memo_detail_screen.dart';
import '../mindmap/mind_map_screen.dart';
import '../settings/settings_screen.dart';
import '../translate/translate_screen.dart';
import 'app_router_contract.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoute.home.path,
  routes: [
    GoRoute(
      path: AppRoute.home.path,
      name: AppRoute.home.name,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: AppRoute.createFolder.path,
      name: AppRoute.createFolder.name,
      builder: (context, state) => const CreateFolderScreen(),
    ),
    GoRoute(
      path: AppRoute.editMemo.path,
      name: AppRoute.editMemo.name,
      builder: (context, state) => const EditMemoScreen(),
    ),
    GoRoute(
      path: AppRoute.memoDetail.path,
      name: AppRoute.memoDetail.name,
      builder: (context, state) => const MemoDetailScreen(),
    ),
    GoRoute(
      path: AppRoute.mindMap.path,
      name: AppRoute.mindMap.name,
      builder: (context, state) => const MindMapScreen(),
    ),
    GoRoute(
      path: AppRoute.settings.path,
      name: AppRoute.settings.name,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoute.translate.path,
      name: AppRoute.translate.name,
      builder: (context, state) => const TranslateScreen(),
    ),
  ],
);
