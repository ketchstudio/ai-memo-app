import 'package:ana_flutter/domain/usecase/file_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/service_locator.dart';
import '../../../../domain/models/app_file.dart';
import '../../../../domain/models/note.dart';
import '../file_picker_with_preview.dart';
import 'create_file_note_event.dart';
import 'create_file_note_state.dart';

class CreateFileNoteBloc
    extends Bloc<CreateFileNoteEvent, CreateFileNoteState> {
  CreateFileNoteBloc() : super(const CreateFileNoteState()) {
    on<FolderSelected>(_onFolderSelected);
    on<SubmitNote>(_onSubmit);
    on<CreateFileNoteInitial>(_initial);
  }

  void _initial(
    CreateFileNoteInitial event,
    Emitter<CreateFileNoteState> emit,
  ) {
    emit(
      state.copyWith(
        title: event.fileName,
        status: CreateFileNoteStatus.initial,
        path: event.path,
        noteType: switch (event.fileType) {
          AppFileType.document => NoteType.document,
          AppFileType.audio => NoteType.audio,
          AppFileType.image => NoteType.image,
          _ => NoteType.unknown,
        },
      ),
    );
  }

  void _onFolderSelected(
    FolderSelected event,
    Emitter<CreateFileNoteState> emit,
  ) {
    emit(
      state.copyWith(
        folderId: event.folderId,
        status: CreateFileNoteStatus.initial,
        folderType: event.folderType,
      ),
    );
  }

  Future<void> _onSubmit(
    SubmitNote event,
    Emitter<CreateFileNoteState> emit,
  ) async {
    if (state.status == CreateFileNoteStatus.submitting) {
      return; // Prevent multiple submissions
    }

    if (state.folderId.isEmpty) {
      emit(
        state.copyWith(
          status: CreateFileNoteStatus.failure,
          errorMessage: 'Please select a folder first.',
        ),
      );
      return;
    }
    emit(state.copyWith(status: CreateFileNoteStatus.submitting));

    final result = await getIt<UploadFileUseCase>().call(
      folderId: state.folderId,
      file: AppFile(
        name: state.title,
        path: state.path,
        type: switch (state.noteType) {
          NoteType.document => AppFileType.document,
          NoteType.audio => AppFileType.audio,
          NoteType.image => AppFileType.image,
          _ => AppFileType.unknown,
        },
      ),
      noteType: state.noteType,
      folderType: state.folderType,
    );

    result.fold(
      (memo) {
        emit(state.copyWith(status: CreateFileNoteStatus.success));
      },
      (error) {
        emit(
          state.copyWith(
            status: CreateFileNoteStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }
}
