import 'package:equatable/equatable.dart';

import '../../../../domain/models/folder.dart';

abstract class FolderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FolderInitial extends FolderState {}

class FolderLoading extends FolderState {}

class FolderLoadSuccess extends FolderState {
  final List<Folder> folders;

  FolderLoadSuccess(this.folders);

  @override
  List<Object?> get props => [folders];
}

class FolderFailure extends FolderState {
  final String message;

  FolderFailure(this.message);

  @override
  List<Object?> get props => [message];
}
