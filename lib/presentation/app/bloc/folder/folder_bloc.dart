import 'dart:async';

import 'package:ana_flutter/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecase/memo/folder_use_case.dart';
import 'folder_event.dart';
import 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  StreamSubscription? _streamSub;

  FolderBloc() : super(FolderInitial()) {
    on<ListenFolders>(_onListenFolders);
    on<CreateFolder>(_onCreateFolder);
    on<EditFolder>(_onEditFolder);
    on<DeleteFolder>(_onDeleteFolder);
    add(ListenFolders());
  }

  // Named factory constructor for the empty version
  FolderBloc.empty() : super(FolderInitial()) {
    // No event handlers, or you can handle all events as no-ops
  }

  void _onListenFolders(ListenFolders event, Emitter<FolderState> emit) async {
    emit(FolderLoading());
    await emit.forEach(
      getIt<GetFoldersStreamUseCase>().call(),
      onData: (result) => result.fold((folders) {
        print('Folders loaded: ${folders.length}');
        return FolderLoadSuccess(folders);
      }, (failure) => FolderFailure(failure.message)),
      onError: (error, stackTrace) => FolderFailure(error.toString()),
    );
  }

  Future<void> _onCreateFolder(
    CreateFolder event,
    Emitter<FolderState> emit,
  ) async {
    emit(FolderLoading());
    final result = await getIt<CreateFolderUseCase>().call(event.name);
    result.fold((_) {}, (failure) => emit(FolderFailure(failure.message)));
  }

  Future<void> _onEditFolder(
    EditFolder event,
    Emitter<FolderState> emit,
  ) async {
    emit(FolderLoading());
    final result = await getIt<EditFolderUseCase>().call(
      event.id,
      event.newName,
    );
    result.fold((_) {}, (failure) => emit(FolderFailure(failure.message)));
  }

  Future<void> _onDeleteFolder(
    DeleteFolder event,
    Emitter<FolderState> emit,
  ) async {
    emit(FolderLoading());
    final result = await getIt<DeleteFolderUseCase>().call(event.id);
    result.fold((_) {}, (failure) => emit(FolderFailure(failure.message)));
  }

  @override
  Future<void> close() {
    _streamSub?.cancel();
    return super.close();
  }
}
