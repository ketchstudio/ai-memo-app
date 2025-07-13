import 'package:equatable/equatable.dart';

class CreateNoteFromTextEvent extends Equatable {
  final String title;
  final String content;

  const CreateNoteFromTextEvent(this.title, this.content);

  @override
  List<Object?> get props => [title, content];
}
