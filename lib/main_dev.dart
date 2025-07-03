import 'package:ana_flutter/ana_app.dart';
import 'package:ana_flutter/utils/env_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnvFile("env/.env.dev");
  await ServiceLocator.configureDependencies();
  runApp(AnaApp());
}
