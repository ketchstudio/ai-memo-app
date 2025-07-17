import '../../../domain/models/folder.dart';

abstract class FolderDataSource {
  Future<List<Folder>> getAll();
  Future<Folder> create(String name);
  Future<void> update(String id, String newName);
  Future<void> delete(String id);
}