import 'package:ana_flutter/presentation/routers/app_router.dart';
import 'package:ana_flutter/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AnaApp extends StatelessWidget {
  const AnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ANA',
      theme: lightTheme,
      routerConfig: appRouter,
    );
  }
}
