import 'dart:async';

import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/folder.dart';
import 'package:ana_flutter/domain/repositories/folder_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rxdart/rxdart.dart';

import '../remote/domain/folder_remote_datasource.dart';

class SupabaseFolderRepository extends FolderRepository {
  final FolderRemoteDataSource _remote;

  SupabaseFolderRepository(this._remote);

  @override
  Stream<ResultDart<List<Folder>, AppError>> observe() => _remote
      .observe()
      .map<ResultDart<List<Folder>, AppError>>((folders) => Success(folders))
      .onErrorReturnWith((e, _) => Failure(ErrorMapper.map(e)));

  @override
  AsyncResultDart<Folder, AppError> add(String name) =>
      runCatchingAsync(() => _remote.add(name));

  @override
  AsyncResultDart<Nothing, AppError> deleteById(String id) =>
      runCatchingAsync(() {
        return _remote.deleteById(id).then((_) => Nothing.instance);
      });

  @override
  AsyncResultDart<Nothing, AppError> edit(String id, String newName) =>
      runCatchingAsync(
        () => _remote.edit(id, newName).then((_) => Nothing.instance),
      );
}
