import 'package:ana_flutter/data/datasource/folder_datasource.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../../domain/models/app_error.dart';
import '../../domain/models/folder.dart';
import 'constant/supabase_database.dart';

class SupabaseRemoteFolderDataSource extends FolderDataSource {
  final SupabaseClient client;

  SupabaseRemoteFolderDataSource(this.client);

  @override
  Future<List<Folder>> getAll() async {
    final response = await client
        .from(SupabaseDatabaseTable.foldersWithNoteCount)
        .select()
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to fetch folders: $e'),
        );
    return response.map((json) => Folder.fromMap(json)).toList();
  }

  @override
  Future<Folder> create(String name) async {
    final response = await client
        .from(SupabaseDatabaseTable.folders)
        .insert({'name': name})
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to create folder: $e'),
        );
    return Folder.fromMap(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> update(String id, String newName) async {
    return client
        .from(SupabaseDatabaseTable.folders)
        .update({'name': newName})
        .eq('id', id)
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to update folder: $e'),
        );
  }

  @override
  Future<void> delete(String id) async {
    return client
        .from(SupabaseDatabaseTable.folders)
        .delete()
        .eq('id', id)
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to delete folder: $e'),
        );
  }
}
