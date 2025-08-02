import 'package:ana_flutter/core/presentation/decoration/app_input_decoration.dart';
import 'package:ana_flutter/core/presentation/snackbar_manager.dart';
import 'package:ana_flutter/presentation/app/bloc/folder/folder_bloc.dart';
import 'package:ana_flutter/presentation/app/bloc/folder/folder_state.dart';
import 'package:ana_flutter/presentation/di/popup/ui_service.dart';
import 'package:ana_flutter/presentation/home/create_from_text/bloc/create_text_note_bloc.dart';
import 'package:ana_flutter/presentation/home/create_from_text/widget/folder_selector.dart';
import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/widget/inverse_text_button.dart';
import '../../../di/service_locator.dart';
import 'bloc/create_note_from_text_event.dart';
import 'bloc/create_note_from_text_state.dart';

void showCreateTextNoteDialog(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => CreateNoteTextDialog(),
  );
}

class CreateNoteTextDialog extends StatefulWidget {
  const CreateNoteTextDialog({super.key});

  @override
  State<CreateNoteTextDialog> createState() => _CreateNoteTextDialogState();
}

class _CreateNoteTextDialogState extends State<CreateNoteTextDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  final bloc = CreateTextNoteBloc();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: bloc.state.title);
    _contentController = TextEditingController(text: bloc.state.content);

    // When the user types, dispatch events—but we never reset .text from build!
    _titleController.addListener(() {
      bloc.add(TitleChanged(_titleController.text));
    });
    _contentController.addListener(() {
      bloc.add(ContentChanged(_contentController.text));
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<CreateTextNoteBloc, CreateTextNoteState>(
        listener: (context, state) {
          if (state.status == CreateTextNoteStatus.success) {
            Navigator.popUntil(context, (route) => route.isFirst);
            SnackbarManager.show(
              message: 'Note created successfully!',
              type: SnackbarType.success,
            );
          }

          if (state.error != null) {
            getIt<UiService>().showErrorDialog(
              context: context,
              error: state.error!,
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

                      // Title input
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _titleController,
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
                          controller: _contentController,
                          minLines: 10,
                          maxLines: 10,
                          maxLength: 10_000_000,
                          decoration: appInputDecoration(
                            context: context,
                            hintText: 'Start typing your note...',
                          ),
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
  }
}
