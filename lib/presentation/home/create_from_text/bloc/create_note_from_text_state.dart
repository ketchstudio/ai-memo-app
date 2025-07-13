import 'package:equatable/equatable.dart';

abstract class CreateNoteFromTextState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNoteFromTextInitial extends CreateNoteFromTextState {}

class CreateNoteFromTextLoading extends CreateNoteFromTextState {}

class CreateNoteFromTextSuccess extends CreateNoteFromTextState {}

class CreateNoteFromTextFailure extends CreateNoteFromTextState {
  final String error;

  CreateNoteFromTextFailure(this.error);

  @override
  List<Object?> get props => [error];
}
