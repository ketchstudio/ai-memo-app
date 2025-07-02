import 'package:ana_flutter/presentation/routers/app_router_contract.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> folders = ['Create Folder', 'All Notes'];

  late String selectedFolder = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        selectedFolder: selectedFolder,
        folders: folders,
        onFolderSelected: (folder) {
          setState(() {
            selectedFolder = folder;
          });
        },
        onNavigateToSettings: () {
          context.push(AppRoute.settings.path);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final route in AppRoute.values)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => context.push(route.path),
                child: Text('Go to ${route.label} screen'),
              ),
            ),
        ],
      ),
    );
  }
}
