import 'package:ana_flutter/domain/usecase/memo/note_use_case.dart';
import 'package:ana_flutter/presentation/home/note/note_ui_item.dart';
import 'package:bloc/bloc.dart';
import 'package:result_dart/result_dart.dart';

import '../../../di/service_locator.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeSelectFolder>(_onHomeSelectFolder);
    on<HomeRefresh>(_onHomeRefresh);
    on<HomeListenNotes>(_onHomeListenNotes);
    add(HomeSelectFolder(HomeConstant.allNotesFolderId));
  }

  void _onHomeSelectFolder(
    HomeSelectFolder event,
    Emitter<HomeState> emit,
  ) async {
    print('Selected folder: ${event.folderId}');
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
    print('Refreshing home...');
    emit(HomeRefreshing());
    await getIt<RefreshNotesWithFolderUpdateUseCase>().call();
  }

  void _onHomeListenNotes(
    HomeListenNotes event,
    Emitter<HomeState> emit,
  ) {
    getIt<GetNotesStreamUseCase>().call().listen((notes) {
      emit(
        Home(
          notes: notes.map((note) => note.toUiItem()).toList(),
        ),
      );
    });
  }
}

class HomeConstant {
  const HomeConstant._();

  static const String allNotesFolderId = 'all';
}
