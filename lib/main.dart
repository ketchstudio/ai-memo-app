import 'package:ana_flutter/ana_app.dart';
import 'package:flutter/material.dart';

import 'di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.configureDependencies();
  runApp(AnaApp());
}
