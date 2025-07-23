import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeSelectFolder extends HomeEvent {
  final String folderId;

  const HomeSelectFolder(this.folderId);

  @override
  List<Object?> get props => [folderId];
}

class HomeRefresh extends HomeEvent {
  const HomeRefresh();

  @override
  List<Object?> get props => [];
}

class HomeListenNotes extends HomeEvent {
  const HomeListenNotes();

  @override
  List<Object?> get props => [];
}

class HomeDeleteNote extends HomeEvent {
  final String noteId;
  final String folderId;

  const HomeDeleteNote(this.noteId, this.folderId);

  @override
  List<Object?> get props => [noteId];
}
