import 'package:ana_flutter/presentation/routers/app_router.dart';
import 'package:flutter/material.dart';

class AnaApp extends StatelessWidget {
  const AnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ANA',
      theme: ThemeData.dark(useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
