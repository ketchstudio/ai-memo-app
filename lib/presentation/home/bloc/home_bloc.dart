import 'package:ana_flutter/domain/usecase/note_use_case.dart';
import 'package:ana_flutter/presentation/home/note/note_ui_item.dart';
import 'package:bloc/bloc.dart';
import 'package:result_dart/result_dart.dart';

import '../../../di/service_locator.dart';
import '../../../domain/models/note.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeSelectFolder>(_onHomeSelectFolder);
    on<HomeRefresh>(_onHomeRefresh);
    on<HomeListenNotes>(_onHomeListenNotes);
    on<HomeDeleteNote>(_onHomeDeleteNote);
    add(HomeSelectFolder(HomeConstant.allNotesFolderId));
    add(HomeListenNotes());
  }

  void _onHomeSelectFolder(
    HomeSelectFolder event,
    Emitter<HomeState> emit,
  ) async {
    if (event.folderId == HomeConstant.allNotesFolderId) {
      await getIt<GetAllNotesUseCase>().call().fold(
        (notes) {
          return emit(
            HomeFolderSelected(
              HomeConstant.allNotesFolderId,
              notes: notes.map((note) => note.toUiItem()).toList(),
            ),
          );
        },
        (error) {
          // Handle error if needed
        },
      );
      return;
    }

    await getIt<GetAllNotesUseCaseById>().call(event.folderId).fold((notes) {
      return emit(
        HomeFolderSelected(
          event.folderId,
          notes: notes.map((note) => note.toUiItem()).toList(),
        ),
      );
    }, (notes) {});
  }

  void _onHomeRefresh(HomeRefresh event, Emitter<HomeState> emit) async {
    await getIt<RefreshNotesWithFolderUpdateUseCase>().call();
  }

  void _onHomeListenNotes(
    HomeListenNotes event,
    Emitter<HomeState> emit,
  ) async {
    return emit.forEach<List<Note>>(
      getIt<GetNotesStreamUseCase>().call(),
      onData: (notes) {
        final noteIds = notes.map((n) => n.folderId).toSet();
        if (!noteIds.contains(state.selectedFolderId)) {
          return HomeNoteUpdated(
            selectedFolderId: HomeConstant.allNotesFolderId,
            notes: notes.map((n) => n.toUiItem()).toList(),
          );
        }

        if (state.selectedFolderId == HomeConstant.allNotesFolderId) {
          return HomeNoteUpdated(
            selectedFolderId: HomeConstant.allNotesFolderId,
            notes: notes.map((n) => n.toUiItem()).toList(),
          );
        }
        final filtered = notes
            .where((n) => n.folderId == state.selectedFolderId)
            .map((n) => n.toUiItem())
            .toList();

        return HomeNoteUpdated(
          selectedFolderId: state.selectedFolderId,
          notes: filtered,
        );
      },
      onError: (err, stack) {
        return HomeInitial();
      },
    );
  }

  void _onHomeDeleteNote(HomeDeleteNote event, Emitter<HomeState> emit) async {
    emit(
      HomeNoteLoading(
        selectedFolderId: state.selectedFolderId,
        notes: state.notes,
      ),
    );
    await getIt<DeleteNoteWithFolderUpdateUseCase>()
        .call(event.noteId, event.folderId)
        .fold(
          (success) => emit(
            HomeNoteDeleted(
              selectedFolderId: state.selectedFolderId,
              notes: state.notes.where((n) => n.id != event.noteId).toList(),
            ),
          ),
          (error) {
            // Handle error if needed
          },
        );
  }
}

class HomeConstant {
  const HomeConstant._();

  static const String allNotesFolderId = 'all';
}
