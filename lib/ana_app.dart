import 'package:ana_flutter/presentation/app/bloc/theme_cubit.dart';
import 'package:ana_flutter/presentation/routers/app_router.dart';
import 'package:ana_flutter/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaApp extends StatelessWidget {
  const AnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp.router(
            title: 'ANA',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: mode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
