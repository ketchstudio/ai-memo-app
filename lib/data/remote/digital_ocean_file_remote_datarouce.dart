import 'dart:io';

import 'package:ana_flutter/data/remote/constant/digital_ocean.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:uni_storage/uni_storage.dart';

import '../datasource/file_remote_datasource.dart';

class DigitalOceanFileRemoteDataSource implements FileRemoteDataSource {
  final Dio dio;
  final String bucketUrl = "https://gamedata.nyc3.digitaloceanspaces.com";

  DigitalOceanFileRemoteDataSource(this.dio);

  @override
  Future<String?> uploadFile({
    required File file,
    required String remotePath,
  }) async {
    final String contentType =
        lookupMimeType(file.path) ?? 'application/octet-stream';
    return await UniStorage.uniStorge
        ?.bucket(DigitalOcean.bucketName)
        .uploadFile(remotePath, file, contentType, Permissions.private);
  }
}
