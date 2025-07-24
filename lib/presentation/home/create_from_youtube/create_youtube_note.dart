import 'package:ana_flutter/core/presentation/decoration/app_input_decoration.dart';
import 'package:ana_flutter/core/presentation/snackbar_manager.dart';
import 'package:ana_flutter/core/presentation/widget/rounded_icon_button.dart';
import 'package:ana_flutter/presentation/app/bloc/folder/folder_bloc.dart';
import 'package:ana_flutter/presentation/app/bloc/folder/folder_state.dart';
import 'package:ana_flutter/presentation/home/create_from_text/widget/folder_selector.dart';
import 'package:ana_flutter/presentation/home/create_from_youtube/bloc/create_youtube_note_bloc.dart';
import 'package:ana_flutter/presentation/theme/app_border_radius.dart';
import 'package:ana_flutter/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/widget/inverse_text_button.dart';
import 'bloc/create_youtube_note_event.dart';
import 'bloc/create_youtube_note_state.dart';

void showCreateYoutubeNoteDialog(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => CreateYoutubeNote(),
  );
}

class CreateYoutubeNote extends StatefulWidget {
  const CreateYoutubeNote({super.key});

  @override
  State<CreateYoutubeNote> createState() => _CreateYoutubeNoteState();
}

class _CreateYoutubeNoteState extends State<CreateYoutubeNote> {
  late final TextEditingController _titleController;
  late final TextEditingController _urlController;
  late final TextEditingController _descriptionController;
  final bloc = CreateYoutubeNoteBloc();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: bloc.state.title);
    _urlController = TextEditingController(text: bloc.state.url);
    _descriptionController = TextEditingController(
      text: bloc.state.description,
    );
    // When the user types, dispatch events—but we never reset .text from build!
    _titleController.addListener(() {
      bloc.add(TitleChanged(_titleController.text));
    });
    _urlController.addListener(() {
      bloc.add(UrlChanged(_urlController.text));
    });
    _descriptionController.addListener(() {
      bloc.add(DescriptionChanged(_descriptionController.text));
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateYoutubeNoteBloc(),
      child: BlocConsumer<CreateYoutubeNoteBloc, CreateYoutubeNoteState>(
        listener: (context, state) {
          if (state.status == CreateYoutubeNoteStatus.success) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            RoundedIconButton(
                              onPressed: () {},
                              borderRadius: AppBorderRadius.circle(),
                              icon: Icons.video_settings,
                              color: Colors.red,
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Add YouTube Video',
                                style: AppTextStyles.titleMedium(
                                  context,
                                ).withFontWeight(FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                      if (state.errorMessage != null &&
                          state.errorMessage!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            state.errorMessage ?? '',
                            style: AppTextStyles.bodyMedium(context)
                                .copyWith(color: Colors.red)
                                .withFontWeight(FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Text(
                          textAlign: TextAlign.left,
                          'Note title...',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).withFontWeight(FontWeight.bold),
                        ),
                      ),

                      // Title input
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _titleController,
                          decoration: appInputDecoration(
                            context: context,
                            hintText: 'Enter note title...',
                          ),
                          onChanged: (v) => context
                              .read<CreateYoutubeNoteBloc>()
                              .add(TitleChanged(v)),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Text(
                          textAlign: TextAlign.left,
                          'Folder',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).withFontWeight(FontWeight.bold),
                        ),
                      ),

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
                                    context.read<CreateYoutubeNoteBloc>().add(
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

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Text(
                          textAlign: TextAlign.left,
                          'YouTube URL',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).withFontWeight(FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _urlController,
                          decoration: appInputDecoration(
                            context: context,
                            hintText: 'https://www.youtube.com/watch?v=...',
                          ),
                          onChanged: (v) => context
                              .read<CreateYoutubeNoteBloc>()
                              .add(UrlChanged(v)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Text(
                          textAlign: TextAlign.left,
                          'Description (Optional)',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).withFontWeight(FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _descriptionController,
                          minLines: 10,
                          maxLines: 10,
                          maxLength: 10_000_000,
                          decoration: appInputDecoration(
                            context: context,
                            hintText:
                                'Add notes or description about this video...',
                          ),
                          onChanged: (v) => context
                              .read<CreateYoutubeNoteBloc>()
                              .add(DescriptionChanged(v)),
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
                                  context.read<CreateYoutubeNoteBloc>().add(
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
                  if (state.status == CreateYoutubeNoteStatus.submitting)
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
