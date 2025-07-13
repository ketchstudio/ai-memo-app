import 'package:ana_flutter/core/presentation/decoration/app_input_decoration.dart';
import 'package:ana_flutter/presentation/home/create_from_text/bloc/create_note_from_text_bloc.dart';
import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/widget/inverse_text_button.dart';
import 'bloc/create_note_from_text_event.dart';
import 'bloc/create_note_from_text_state.dart';

void showCreateTextNoteDialog(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      final titleController = TextEditingController();
      final contentController = TextEditingController();
      return BlocProvider(
        create: (context) => CreateNoteFromTextBloc(),
        child: BlocBuilder<CreateNoteFromTextBloc, CreateNoteFromTextState>(
          builder: (context, state) {
            return Center(
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppBorderRadius.card,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Create Text Note',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.close),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Title input
                      TextField(
                        controller: titleController,
                        decoration: appInputDecoration(
                          context: context,
                          hintText: 'Note title...',
                        ),
                      ),

                      SizedBox(height: 16),

                      // Content input
                      TextField(
                        controller: contentController,
                        minLines: 10,
                        maxLines: 10,
                        maxLength: 10_000_000,
                        decoration: appInputDecoration(
                          context: context,
                          hintText: 'Start typing your note...',
                        ),
                      ),

                      SizedBox(height: 20),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: InverseTextButton(
                              text: 'Cancel',
                              onPressed: () => Navigator.pop(context),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.1),
                              textStyle: AppTextStyles.bodyMedium(
                                context,
                              ).withFontWeight(FontWeight.bold),
                              textColor: Theme.of(
                                context,
                              ).colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: InverseTextButton(
                              text: 'Save Note',
                              onPressed: () {
                                context.read<CreateNoteFromTextBloc>().add(
                                  CreateNoteFromTextEvent(
                                    titleController.text,
                                    contentController.text,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              textStyle: AppTextStyles.bodyMedium(
                                context,
                              ).withFontWeight(FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
