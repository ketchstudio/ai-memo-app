// create_text_note_bloc.dart
import 'package:ana_flutter/domain/models/create_note_request.dart';
import 'package:ana_flutter/domain/usecase/memo/note_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/service_locator.dart';
import '../../../../domain/models/note.dart';
import 'create_note_from_text_event.dart';
import 'create_note_from_text_state.dart';

class CreateTextNoteBloc
    extends Bloc<CreateTextNoteEvent, CreateTextNoteState> {
  CreateTextNoteBloc() : super(const CreateTextNoteState()) {
    on<TitleChanged>(_onTitleChanged);
    on<ContentChanged>(_onContentChanged);
    on<FolderSelected>(_onFolderSelected);
    on<SubmitNote>(_onSubmit);
  }

  void _onTitleChanged(TitleChanged event, Emitter<CreateTextNoteState> emit) {
    emit(
      state.copyWith(title: event.title, status: CreateTextNoteStatus.initial),
    );
  }

  void _onContentChanged(
    ContentChanged event,
    Emitter<CreateTextNoteState> emit,
  ) {
    emit(
      state.copyWith(
        content: event.content,
        status: CreateTextNoteStatus.initial,
      ),
    );
  }

  void _onFolderSelected(
    FolderSelected event,
    Emitter<CreateTextNoteState> emit,
  ) {
    emit(
      state.copyWith(
        folderId: event.folderId,
        status: CreateTextNoteStatus.initial,
        folderType: event.folderType,
      ),
    );
  }

  Future<void> _onSubmit(
    SubmitNote event,
    Emitter<CreateTextNoteState> emit,
  ) async {
    if (state.title.isEmpty ||
        state.content.isEmpty ||
        state.folderId.isEmpty) {
      emit(
        state.copyWith(
          status: CreateTextNoteStatus.failure,
          errorMessage: 'Please fill all fields.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: CreateTextNoteStatus.submitting));

    final result = await getIt<CreateNoteWithFolderUpdateUseCase>().call(
      CreateNoteRequest(
        title: state.title,
        content: state.content,
        folderId: state.folderId,
        folderType: state.folderType,
        type: NoteType.text,
      ),
    );

    result.fold(
      (memo) {
        emit(state.copyWith(status: CreateTextNoteStatus.success));
      },
      (error) {
        emit(
          state.copyWith(
            status: CreateTextNoteStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }
}
