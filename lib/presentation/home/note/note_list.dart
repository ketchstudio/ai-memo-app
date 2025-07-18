import 'package:ana_flutter/presentation/home/note/note_ui_item.dart';
import 'package:flutter/cupertino.dart';

import 'note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: dummyNotes.map(
          (note) => note.toUiItem()
      )
          .map((ui) => NoteCard(
            item: ui,
            onMenuTap: () {
              // Handle menu tap
            },
      ))
          .toList(),
    );
  }
}