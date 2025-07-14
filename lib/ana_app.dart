import 'package:ana_flutter/presentation/app/bloc/folder/folder_bloc.dart';
import 'package:ana_flutter/presentation/app/bloc/folder/folder_event.dart';
import 'package:ana_flutter/presentation/app/bloc/theme_cubit.dart';
import 'package:ana_flutter/presentation/login/bloc/auth_bloc.dart';
import 'package:ana_flutter/presentation/routers/app_router.dart';
import 'package:ana_flutter/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaApp extends StatelessWidget {
  AnaApp({super.key});

  // Initialize blocs
  final authBloc = AuthBloc();
  final themeCubit = ThemeCubit();

  // Configure router

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          // Provide FolderBloc ONLY if authenticated!
          return BlocProvider<FolderBloc>(
            // key ensures a fresh FolderBloc after login/logout
            key: ValueKey(authState is AuthAuthenticated),
            create: (_) =>
            authState is AuthAuthenticated
                ? FolderBloc()
                : FolderBloc.empty(), // or a dummy/inactive bloc if needed
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) {
                return MaterialApp.router(
                  title: 'ANA',
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: mode,
                  routerConfig: AppRouter(
                    isAuth: authState is AuthAuthenticated,
                  ).router,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
