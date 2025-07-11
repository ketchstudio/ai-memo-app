import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home(path: '/', name: 'home', label: 'Home'),
  createFolder(
    path: '/create-folder',
    name: 'createFolder',
    label: 'Create Folder',
  ),
  editMemo(path: '/edit-memo', name: 'editMemo', label: 'Edit Memo'),
  memoDetail(path: '/memo-detail', name: 'memoDetail', label: 'Memo Detail'),
  mindMap(path: '/mind-map', name: 'mindMap', label: 'Mind Map'),
  settings(path: '/settings', name: 'settings', label: 'Settings'),
  translate(path: '/translate', name: 'translate', label: 'Translate'),
  explore(path: '/explore', name: 'explore', label: 'explore');

  const AppRoute({required this.path, required this.name, required this.label});

  final String path;
  final String name;
  final String label;
}

GoRoute buildRoute(AppRoute route, Widget Function(GoRouterState) builder) {
  return GoRoute(
    path: route.path,
    name: route.name,
    builder: (context, state) => builder(state),
  );
}
