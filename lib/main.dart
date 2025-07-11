import 'package:ana_flutter/ana_app.dart';
import 'package:ana_flutter/core/config/env_key.dart';
import 'package:ana_flutter/utils/env_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await loadEnvFile(".env.dev");
  await Supabase.initialize(
    url: getEnvVariable(EnvironmentKey.supabaseUrl)!,
    anonKey: getEnvVariable(EnvironmentKey.supabaseAnonKey)!,
    authOptions: FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce, // Use PKCE for secure authentication
    ),
  );
  await ServiceLocator.configureDependencies();
  runApp(AnaApp());
}
