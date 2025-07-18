import 'package:ana_flutter/presentation/home/folder/folder_contract.dart';
import 'package:equatable/equatable.dart';

abstract class FolderState extends Equatable {
  /// The current list of folders (may be empty).
  final List<FolderUiItem> folders;

  const FolderState(this.folders);

  @override
  List<Object?> get props => [folders];
}

class FolderInitial extends FolderState {
  /// At startup, we have no folders yet.
  const FolderInitial() : super(const []);
}

class FolderLoading extends FolderState {
  /// While loading, you can choose to show the last‐known folders (or empty).
  const FolderLoading(super.folders);
}

class FolderLoadSuccess extends FolderState {
  /// On success you always have your fresh folders.
  const FolderLoadSuccess(super.folders);
}

class FolderFailure extends FolderState {
  /// Carry an error message *and* the last folders you had.
  final String message;

  const FolderFailure({
    required this.message,
    required List<FolderUiItem> folders,
  }) : super(folders);

  @override
  List<Object?> get props => [message, ...folders];
}

class EditFolderLoadSuccess extends FolderState {
  const EditFolderLoadSuccess(super.folders);
}

class DeleteFolderLoadSuccess extends FolderState {
  const DeleteFolderLoadSuccess(super.folders);
}

class CreatingFolderLoadSuccess extends FolderState {
  const CreatingFolderLoadSuccess(super.folders);
}

class CreateFolderLoadSuccess extends FolderState {
  const CreateFolderLoadSuccess(super.folders);
}
