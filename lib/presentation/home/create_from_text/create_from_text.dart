import 'package:ana_flutter/core/presentation/decoration/app_input_decoration.dart';
import 'package:ana_flutter/core/presentation/snackbar_manager.dart';
import 'package:ana_flutter/presentation/app/bloc/folder/folder_bloc.dart';
import 'package:ana_flutter/presentation/app/bloc/folder/folder_state.dart';
import 'package:ana_flutter/presentation/home/create_from_text/bloc/create_note_from_text_bloc.dart';
import 'package:ana_flutter/presentation/home/create_from_text/widget/folder_selector.dart';
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
      return BlocProvider(
        create: (context) => CreateTextNoteBloc(),
        child: BlocConsumer<CreateTextNoteBloc, CreateTextNoteState>(
          listener: (context, state) {
            if (state.status == CreateTextNoteStatus.success) {
              Navigator.popUntil(context, (route) => route.isFirst);
              SnackbarManager.show(
                message: 'Note created successfully!',
                type: SnackbarType.success,
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppBorderRadius.card,
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
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
                        ),
                        SizedBox(height: 16),

                        if (state.errorMessage != null &&
                            state.errorMessage!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.errorMessage ?? '',
                              style: AppTextStyles.bodyMedium(context)
                                  .copyWith(color: Colors.red)
                                  .withFontWeight(FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),

                        // Title input
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: TextEditingController(
                              text: state.title,
                            ),
                            decoration: appInputDecoration(
                              context: context,
                              hintText: 'Note title...',
                            ),
                            onChanged: (v) => context
                                .read<CreateTextNoteBloc>()
                                .add(TitleChanged(v)),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Folder selector
                        BlocBuilder<FolderBloc, FolderState>(
                          builder: (context, folderState) {
                            return Stack(
                              children: [
                                FolderSelector(
                                  folders: folderState.folders,
                                  selectedIndex: folderState.folders.indexWhere(
                                    (f) => f.id == state.folderId,
                                  ),
                                  onSelected: (id) =>
                                      context.read<CreateTextNoteBloc>().add(
                                        FolderSelected(
                                          folderState.folders[id].id,
                                          folderState.folders[id].type,
                                        ),
                                      ),
                                ),
                                if (folderState is FolderLoading)
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              ],
                            );
                          },
                        ),

                        SizedBox(height: 16),

                        // Content input
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: TextEditingController(
                              text: state.content,
                            ),
                            minLines: 10,
                            maxLines: 10,
                            maxLength: 10_000_000,
                            decoration: appInputDecoration(
                              context: context,
                              hintText: 'Start typing your note...',
                            ),
                            onChanged: (v) => context
                                .read<CreateTextNoteBloc>()
                                .add(ContentChanged(v)),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Action buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: InverseTextButton(
                                  text: 'Cancel',
                                  onPressed: () => Navigator.pop(context),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.1),
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
                                    context.read<CreateTextNoteBloc>().add(
                                      SubmitNote(),
                                    );
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
                        ),
                      ],
                    ),
                    if (state.status == CreateTextNoteStatus.submitting)
                      const Positioned.fill(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
