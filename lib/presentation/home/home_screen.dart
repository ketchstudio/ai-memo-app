import 'package:ana_flutter/presentation/home/create_from_text/create_from_text.dart';
import 'package:ana_flutter/presentation/home/home_main_action.dart';
import 'package:ana_flutter/presentation/routers/app_router_contract.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'action/note_create_option_bottomsheet.dart';
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
        onSettingsPressed: () => context.push(AppRoute.settings.path),
      ),
      body: SafeArea(
        child: Stack(
          children: [
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
