import 'package:ana_flutter/domain/models/app_error.dart';
import 'package:ana_flutter/domain/models/create_note_request.dart';
import 'package:ana_flutter/domain/models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../datasource/note_remote_datasource.dart';
import 'constant/supabase_database.dart';

class SupabaseNoteRemoteDataSource implements NoteRemoteDataSource {
  final SupabaseClient client;

  SupabaseNoteRemoteDataSource(this.client);

  @override
  Future<Note> create({required CreateNoteRequest body}) async {
    final response = await client
        .from(SupabaseDatabaseTable.notes)
        .insert(body.toJson())
        .select()
        .single()
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to create note: $e'),
        );

    return Note.fromJson(response);
  }

  @override
  Future<void> delete(String id) {
    return client
        .from(SupabaseDatabaseTable.notes)
        .delete()
        .eq('id', id)
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to delete note: $e'),
        );
  }

  @override
  Future<List<Note>> getAll() {
    return client
        .from(SupabaseDatabaseTable.notes)
        .select()
        .order('created_at', ascending: true)
        .onError(
          (e, stacktrace) => throw NetworkError('Failed to fetch notes: $e'),
        )
        .then(
          (response) =>
              (response as List).map((json) => Note.fromJson(json)).toList(),
        );
  }
}
