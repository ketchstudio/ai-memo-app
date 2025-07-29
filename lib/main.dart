import 'package:ana_flutter/ana_app.dart';
import 'package:ana_flutter/core/config/env_key.dart';
import 'package:ana_flutter/utils/env_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_storage/uni_storage.dart';

import 'core/data/logger/supabase_http_logger.dart';
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
    httpClient: SupabaseHttpClient(),
  );
  await UniStorage.init(
    region: "nyc3",
    accessKey: "DO00JWL4PR6BWCF2UP6X",
    secretKey: "O/Nh12nxVIkVGQsXG0YAWAuXdxq94baVSZDbfRqn3wk",
  );
  await ServiceLocator.configureDependencies();
  runApp(AnaApp());
}
