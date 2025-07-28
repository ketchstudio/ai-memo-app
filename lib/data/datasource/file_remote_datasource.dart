import 'dart:io';

abstract class FileRemoteDataSource {
  Future<String?> uploadFile({required File file, required String remotePath});
}
