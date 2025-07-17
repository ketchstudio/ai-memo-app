import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/models/folder.dart';
import '../../domain/repositories/folder_repository.dart';
import '../inmemory/folder_in_memory_datasource.dart';
import '../remote/supabase_folder_remote_datasource.dart';

class DefaultFolderRepository implements FolderRepository {
  final MemoryFolderDataSource _local;
  final SupabaseRemoteFolderDataSource _remote;

  DefaultFolderRepository(this._local, this._remote);

  @override
  Stream<List<Folder>> observe() => _local.observe();

  @override
  AsyncResultDart<List<Folder>, AppError> getAll() =>
      runCatchingAsync(() async {
        final localFolders = await _local.getAll();
        if (localFolders.isNotEmpty) {
          return localFolders;
        } else {
          final remoteFolders = await _remote.getAll();
          await _local.setAll(remoteFolders);
          return remoteFolders;
        }
      });

  @override
  AsyncResultDart<Folder, AppError> create(String name) async {
    return runCatchingAsync(() async {
      final remoteFolder = await _remote.create(name);
      await _local.create(remoteFolder);
      return remoteFolder;
    });
  }

  @override
  AsyncResultDart<Nothing, AppError> update(String id, String newName) =>
      runCatchingAsync(() async {
        await _remote.update(id, newName);
        await _local.update(id, newName);
        return Nothing.instance;
      });

  @override
  AsyncResultDart<Nothing, AppError> delete(String id) =>
      runCatchingAsync(() async {
        await _remote.delete(id);
        await _local.delete(id);
        return Nothing.instance;
      });

  @override
  AsyncResultDart<Nothing, AppError> refresh() => runCatchingAsync(() async {
    final remoteFolders = await _remote.getAll();
    _local.setAll(remoteFolders);
    return Nothing.instance;
  });

  @override
  AsyncResultDart<Nothing, AppError> incrementNoteCount(String folderId) =>
      runCatchingAsync(() async {
        _local.incrementNoteCount(folderId);
        return Nothing.instance;
      });

  @override
  AsyncResultDart<Nothing, AppError> decrementNoteCount(String folderId) =>
      runCatchingAsync(() async {
        _local.decrementNoteCount(folderId);
        return Nothing.instance;
      });
}
