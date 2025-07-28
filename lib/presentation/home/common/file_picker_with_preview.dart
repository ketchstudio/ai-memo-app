import 'dart:io';
import 'dart:math';

import 'package:ana_flutter/core/presentation/decoration/app_input_decoration.dart';
import 'package:ana_flutter/core/presentation/snackbar_manager.dart';
import 'package:ana_flutter/presentation/home/common/bloc/create_file_note_bloc.dart';
import 'package:ana_flutter/presentation/home/common/bloc/create_file_note_event.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

import '../../../core/presentation/widget/inverse_text_button.dart';
import '../../app/bloc/folder/folder_bloc.dart';
import '../../app/bloc/folder/folder_state.dart';
import '../../theme/app_text_styles.dart';
import '../create_from_text/widget/folder_selector.dart';
import 'bloc/create_file_note_state.dart';

enum AppFileType { audio, image, document, unknown }

extension AppFileTypeExtension on AppFileType {
  List<String> get allowedExtensions {
    switch (this) {
      case AppFileType.audio:
        return ['mp3', 'm4a', 'wav', 'aac'];
      case AppFileType.image:
        return ['jpg', 'jpeg', 'png', 'gif'];
      case AppFileType.document:
        return ['pdf', 'docx', 'txt'];
      case AppFileType.unknown:
        return [];
    }
  }

  Color get iconColor {
    switch (this) {
      case AppFileType.audio:
        return Colors.redAccent;
      case AppFileType.image:
        return Colors.green;
      case AppFileType.document:
        return Colors.purple;
      case AppFileType.unknown:
        return Colors.grey;
    }
  }

  String get label {
    switch (this) {
      case AppFileType.audio:
        return 'Audio';
      case AppFileType.image:
        return 'Image';
      case AppFileType.document:
        return 'Document';
      case AppFileType.unknown:
        return 'Unknown';
    }
  }

  IconData get icon {
    switch (this) {
      case AppFileType.audio:
        return Icons.audiotrack;
      case AppFileType.image:
        return Icons.image;
      case AppFileType.document:
        return Icons.description;
      case AppFileType.unknown:
        return Icons.help_outline;
    }
  }
}

class SelectFileDialog extends StatelessWidget {
  final String fileName;
  final AppFileType fileType;
  final String fileSize;
  final String fileExtension;
  final String path;

  const SelectFileDialog({
    super.key,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.fileExtension,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateFileNoteBloc()
        ..add(
          CreateFileNoteInitial(
            fileType: fileType,
            fileName: fileName,
            fileSize: fileSize,
            fileExtension: fileExtension,
            path: path,
          ),
        ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: BlocConsumer<CreateFileNoteBloc, CreateFileNoteState>(
            listener: (context, state) {
              if (state.status == CreateFileNoteStatus.success) {
                Navigator.popUntil(context, (route) => route.isFirst);
                SnackbarManager.show(
                  message: 'File note created successfully!',
                  type: SnackbarType.success,
                );
              }

              if (state.status == CreateFileNoteStatus.failure) {
                SnackbarManager.show(
                  message: state.errorMessage ?? 'Failed to create file note.',
                  type: SnackbarType.error,
                );
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                        child: Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: fileType.iconColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            fileType.icon,
                            // optionally: change based on fileType
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      ),
                      const Text(
                        "Selected File",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          initialValue: fileName,
                          decoration: appInputDecoration(context: context),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(height: 12),

                      if (state.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            state.errorMessage!,
                            style: AppTextStyles.bodySmall(
                              context,
                            ).copyWith(color: Colors.red),
                          ),
                        ),

                      BlocBuilder<FolderBloc, FolderState>(
                        builder: (context, folderState) {
                          return FolderSelector(
                            folders: folderState.folders,
                            selectedIndex: folderState.folders.indexWhere(
                              (f) => f.id == state.folderId,
                            ),
                            onSelected: (index) {
                              print('Selected folder index: $index');
                              final item = folderState.folders[index];
                              context.read<CreateFileNoteBloc>().add(
                                FolderSelected(item.id, item.type),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                context,
                                "File Type",
                                "${fileExtension.toUpperCase()} ${fileType.label}",
                              ),
                              const SizedBox(height: 8),
                              _buildInfoRow(context, "File Size", fileSize),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
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
                            const SizedBox(width: 12),
                            Expanded(
                              child: InverseTextButton(
                                text: 'Save Note',
                                onPressed: () {
                                  context.read<CreateFileNoteBloc>().add(
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
                  if (state.status == CreateFileNoteStatus.submitting)
                    const Positioned.fill(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium(context)),
        Text(
          value,
          style: AppTextStyles.bodyMedium(context).copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

void pickAndShowPreview(BuildContext context, AppFileType fileType) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: fileType.allowedExtensions,
  );

  if (result == null || result.files.single.path == null) return;

  final path = result.files.single.path;

  if (path == null) {
    SnackbarManager.show(
      message: "File selection was cancelled or no file was selected.",
    );
    return;
  }

  final file = File(path);
  final fileName = p.basename(file.path);
  final fileSize = await file.length();
  final readableSize = formatBytes(fileSize);
  final fileExtension = p.extension(path).replaceFirst('.', '').toLowerCase();

  if (!context.mounted) return;

  if (fileSize > 5 * 1024 * 1024) {
    showFileSizeLimitDialog(context);
    return;
  }

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => SelectFileDialog(
      fileName: fileName,
      fileType: fileType,
      fileSize: readableSize,
      fileExtension: fileExtension,
      path: path,
    ),
  );
}

String formatBytes(int bytes, [int decimals = 1]) {
  if (bytes <= 0) return "0 B";
  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
  final i = (log(bytes) / log(1024)).floor();
  final size = bytes / pow(1024, i);
  return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
}

void showFileSizeLimitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("File Size Limit Reached"),
      content: const Text("The selected file exceeds the 5MB limit."),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
