import 'package:ana_flutter/core/result/result_ext.dart';
import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/create_note_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../datasource/note_remote_datasource.dart';
import 'constant/supabase_database.dart';

class SupabaseNoteRemoteDataSource implements NoteRemoteDataSource {
  final SupabaseClient client;

  SupabaseNoteRemoteDataSource(this.client);

  @override
  Future<Nothing> pushNote({required CreateNoteRequest body}) async {
    await client
        .from(SupabaseDatabaseTable.notes)
        .insert({
          'title': body.title,
          'content': body.content,
          'folder_id': body.folderId,
        })
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to create note: $e'),
        );

    return Nothing.instance;
  }
}
