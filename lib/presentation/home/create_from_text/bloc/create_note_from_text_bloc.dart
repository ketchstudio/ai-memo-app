import 'package:ana_flutter/di/service_locator.dart';
import 'package:ana_flutter/domain/models/create_note_request.dart';
import 'package:ana_flutter/domain/usecase/memo/create_note_use_case.dart';
import 'package:ana_flutter/presentation/home/create_from_text/bloc/create_note_from_text_state.dart';
import 'package:bloc/bloc.dart';

import 'create_note_from_text_event.dart';

class CreateNoteFromTextBloc
    extends Bloc<CreateNoteFromTextEvent, CreateNoteFromTextState> {
  CreateNoteFromTextBloc() : super(CreateNoteFromTextInitial()) {
    on<CreateNoteFromTextEvent>(_onCreateNote);
  }

  Future<void> _onCreateNote(
    CreateNoteFromTextEvent event,
    Emitter<CreateNoteFromTextState> emit,
  ) async {
    emit(CreateNoteFromTextLoading());
    final result = await getIt<InsertMemoUseCase>().call(
      params: CreateNoteRequest(
        title: event.title,
        content: event.content,
        folderId:
            '0a1987c0-1afb-4234-a986-3c067247ee7c', // TODO: Replace with actual folder ID
      ),
    );
    result.fold(
      (_) => emit(CreateNoteFromTextSuccess()),
      (e) => emit(CreateNoteFromTextFailure(e.message)),
    );
  }
}
