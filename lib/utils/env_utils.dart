import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';

FutureOr<void> loadEnvFile(String fileName) async {
  try {
    await dotenv.load(fileName: fileName);
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
}

String? getEnvVariable(String key) {
  return dotenv.env[key];
}
