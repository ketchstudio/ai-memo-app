import 'package:ana_flutter/ana_app.dart';
import 'package:ana_flutter/utils/env_utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnvFile(".env.dev");
  await Supabase.initialize(
    url: getEnvVariable('SUPABASE_URL')!,
    anonKey: getEnvVariable('SUPABASE_ANON_KEY')!,
    authOptions: FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce, // Use PKCE for secure authentication
    ),
  );
  await ServiceLocator.configureDependencies();
  runApp(AnaApp());
}
