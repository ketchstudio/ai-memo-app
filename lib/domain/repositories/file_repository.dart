import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../models/app_file.dart';

abstract class FileRepository {
  AsyncResultDart<String, AppError> uploadFile(AppFile file, String userId);
}
