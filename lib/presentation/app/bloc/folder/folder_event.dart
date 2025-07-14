import 'package:equatable/equatable.dart';

abstract class FolderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListenFolders extends FolderEvent {}

class CreateFolder extends FolderEvent {
  final String name;

  CreateFolder(this.name);

  @override
  List<Object?> get props => [name];
}

class EditFolder extends FolderEvent {
  final String id;
  final String newName;

  EditFolder(this.id, this.newName);

  @override
  List<Object?> get props => [id, newName];
}

class DeleteFolder extends FolderEvent {
  final String id;

  DeleteFolder(this.id);

  @override
  List<Object?> get props => [id];
}
