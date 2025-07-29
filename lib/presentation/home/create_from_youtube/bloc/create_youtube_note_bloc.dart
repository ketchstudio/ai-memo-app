import 'package:ana_flutter/domain/models/create_note_request.dart';
import 'package:ana_flutter/domain/usecase/note_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/service_locator.dart';
import '../../../../domain/models/note.dart';
import 'create_youtube_note_event.dart';
import 'create_youtube_note_state.dart';

class CreateYoutubeNoteBloc
    extends Bloc<CreateYoutubeNoteEvent, CreateYoutubeNoteState> {
  CreateYoutubeNoteBloc() : super(const CreateYoutubeNoteState()) {
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<UrlChanged>(_onUrlChanged);
    on<FolderSelected>(_onFolderSelected);
    on<SubmitNote>(_onSubmit);
  }

  void _onTitleChanged(
    TitleChanged event,
    Emitter<CreateYoutubeNoteState> emit,
  ) {
    emit(
      state.copyWith(
        title: event.title,
        status: CreateYoutubeNoteStatus.initial,
      ),
    );
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<CreateYoutubeNoteState> emit,
  ) {
    emit(
      state.copyWith(
        description: event.description,
        status: CreateYoutubeNoteStatus.initial,
      ),
    );
  }

  void _onUrlChanged(UrlChanged event, Emitter<CreateYoutubeNoteState> emit) {
    emit(
      state.copyWith(url: event.url, status: CreateYoutubeNoteStatus.initial),
    );
  }

  void _onFolderSelected(
    FolderSelected event,
    Emitter<CreateYoutubeNoteState> emit,
  ) {
    emit(
      state.copyWith(
        folderId: event.folderId,
        status: CreateYoutubeNoteStatus.initial,
        folderType: event.folderType,
      ),
    );
  }

  Future<void> _onSubmit(
    SubmitNote event,
    Emitter<CreateYoutubeNoteState> emit,
  ) async {
    if(state.status == CreateYoutubeNoteStatus.submitting) {
      return; // Prevent multiple submissions
    }
    if (state.title.isEmpty || state.url.isEmpty || state.folderId.isEmpty) {
      emit(
        state.copyWith(
          status: CreateYoutubeNoteStatus.failure,
          errorMessage: 'Please fill all fields.',
        ),
      );
      return;
    }

    if (!isValidYoutubeUrl(state.url)) {
      emit(
        state.copyWith(
          status: CreateYoutubeNoteStatus.failure,
          errorMessage: 'Invalid YouTube URL.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: CreateYoutubeNoteStatus.submitting));

    final result = await getIt<CreateNoteWithFolderUpdateUseCase>().call(
      CreateNoteRequest(
        title: state.title,
        content: state.description,
        folderId: state.folderId,
        folderType: state.folderType,
        type: NoteType.video,
        url: state.url,
      ),
    );

    result.fold(
      (memo) {
        emit(state.copyWith(status: CreateYoutubeNoteStatus.success));
      },
      (error) {
        emit(
          state.copyWith(
            status: CreateYoutubeNoteStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }
}

bool isValidYoutubeUrl(String url) {
  final youtubeRegExp = RegExp(
    r'^(https?:\/\/)?' // optional scheme
    r'(www\.)?' // optional www
    r'(youtube\.com\/(watch\?v=|embed\/|v\/)|youtu\.be\/)' // host + path
    r'([A-Za-z0-9_-]{11})' // video id is 11 chars
    r'([&?]\S*)?$', // optional query params
    caseSensitive: false,
  );
  return youtubeRegExp.hasMatch(url.trim());
}
