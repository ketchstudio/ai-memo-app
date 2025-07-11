import 'package:ana_flutter/presentation/routers/app_router.dart';
import 'package:ana_flutter/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnaApp extends StatelessWidget {
  const AnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ANA',
      theme: lightTheme.copyWith(textTheme: GoogleFonts.interTextTheme()),
      darkTheme: ThemeData.dark(useMaterial3: true), // Dark mode theme
      themeMode: ThemeMode.system, // Use system setting
      routerConfig: appRouter,
    );
  }
}
