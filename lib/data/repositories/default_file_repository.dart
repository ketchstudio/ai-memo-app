import 'dart:io';

import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/app_file.dart';
import 'package:result_dart/src/async_result.dart';

import '../../core/result/result_ext.dart';
import '../../domain/repositories/file_repository.dart';
import '../datasource/file_remote_datasource.dart';

class DefaultFileRepository extends FileRepository {
  final FileRemoteDataSource remote;

  DefaultFileRepository(this.remote);

  @override
  AsyncResultDart<String, AppError> uploadFile(AppFile file, String userId) =>
      runCatchingAsync(() async {
        final extension = file.name.split('.').last;
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final remotePath =
            'app-ana/uploads/$userId/${file.type.name}/$timestamp.$extension';
        return await remote
            .uploadFile(file: File(file.path), remotePath: remotePath)
            .then((_) => remotePath);
      });
}
