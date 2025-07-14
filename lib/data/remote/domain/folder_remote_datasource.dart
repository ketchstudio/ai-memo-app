import '../../../domain/models/folder.dart';

abstract class FolderRemoteDataSource {
  Stream<List<Folder>> observe();

  Future<Folder> add(String name);

  Future<void> edit(String id, String newName);

  Future<void> deleteById(String id);
}
