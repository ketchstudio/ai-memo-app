import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../../domain/models/app_error.dart';
import '../../domain/models/folder.dart';
import 'constant/supabase_database.dart';
import 'domain/folder_remote_datasource.dart';

class SupabaseFolderDataSource extends FolderRemoteDataSource {
  final SupabaseClient client;

  SupabaseFolderDataSource(this.client);

  Stream<List<Folder>> observe() async* {
    await for (final event
        in client
            .from(SupabaseDatabaseTable.foldersWithNoteCount)
            .stream(primaryKey: ['id'])
            .distinct()) {
      final folders = event.map((json) => Folder.fromMap(json)).toList();

      if (folders.isEmpty) {
        await _ensureDefaultFolders();
        // Next iteration will pick up inserted folders
      }
      yield folders;
    }
  }

  Future<void> _ensureDefaultFolders() async {
    add('Work');
    add('Personal');
    add('Study');
    add('Idea');
  }

  @override
  Future<Folder> add(String name) async {
    final response = await client
        .from(SupabaseDatabaseTable.folders)
        .insert({'name': name})
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to create folder: $e'),
        );
    return Folder.fromMap(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> edit(String id, String newName) async {
    return client
        .from('folders')
        .update({'name': newName})
        .eq('id', id)
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to update folder: $e'),
        );
  }

  @override
  Future<void> deleteById(String id) async {
    return client
        .from('folders')
        .delete()
        .eq('id', id)
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to delete folder: $e'),
        );
  }
}
