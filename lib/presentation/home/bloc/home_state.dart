import 'package:ana_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:ana_flutter/presentation/home/note/note_ui_item.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  final String selectedFolderId;
  final List<NoteUiItem> notes;

  const HomeState({required this.selectedFolderId, required this.notes});
}

class HomeInitial extends HomeState {
  HomeInitial()
    : super(
        selectedFolderId: HomeConstant.allNotesFolderId,
        notes: <NoteUiItem>[],
      );

  @override
  List<Object?> get props => [selectedFolderId];
}

class HomeFolderSelected extends HomeState {
  const HomeFolderSelected(String selectedFolderId, {required super.notes})
    : super(selectedFolderId: selectedFolderId);

  @override
  List<Object?> get props => [selectedFolderId];
}

class HomeRefreshing extends HomeState {
  HomeRefreshing()
    : super(
        selectedFolderId: HomeConstant.allNotesFolderId,
        notes: <NoteUiItem>[],
      );

  @override
  List<Object?> get props => [selectedFolderId];
}
