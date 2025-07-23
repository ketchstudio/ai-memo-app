import 'package:ana_flutter/presentation/home/note/note_ui_item.dart';
import 'package:flutter/cupertino.dart';

import 'note_card.dart';

class NotesList extends StatelessWidget {
  final List<NoteUiItem> notes;

  const NotesList({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: notes
          .map((note) => note)
          .map(
            (ui) => NoteCard(
              item: ui,
              onMenuTap: () {
                // Handle menu tap
              },
            ),
          )
          .toList(),
    );
  }
}
