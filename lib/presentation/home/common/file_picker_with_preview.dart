import 'dart:io';
import 'dart:math';

import 'package:ana_flutter/core/presentation/decoration/app_input_decoration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../../core/presentation/widget/inverse_text_button.dart';
import '../../theme/app_text_styles.dart';

enum AppFileType { audio, image, document }

extension AppFileTypeExtension on AppFileType {
  List<String> get allowedExtensions {
    switch (this) {
      case AppFileType.audio:
        return ['mp3', 'm4a', 'wav', 'aac'];
      case AppFileType.image:
        return ['jpg', 'jpeg', 'png', 'gif'];
      case AppFileType.document:
        return ['pdf', 'docx', 'txt'];
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
    }
  }
}

class SelectFileDialog extends StatelessWidget {
  final String fileName;
  final AppFileType fileType;
  final String fileSize;
  final String fileExtension;

  const SelectFileDialog({
    super.key,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.fileExtension,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
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
                  fileType.icon, // optionally: change based on fileType
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
            const Text("Selected File", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: fileName,
              decoration: appInputDecoration(context: context),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildInfoRow(
                    "File Type",
                    "${fileExtension.toUpperCase()} ${fileType.label}",
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow("File Size", fileSize),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
                    textColor: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InverseTextButton(
                    text: 'Save Note',
                    onPressed: () {},
                    backgroundColor: Theme.of(context).colorScheme.primary,
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
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
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

  final file = File(result.files.single.path!);
  final fileName = p.basename(file.path);
  final fileSize = await file.length();
  final readableSize = formatBytes(fileSize);
  final fileExtension = p
      .extension(file.path)
      .replaceFirst('.', '')
      .toLowerCase();

  if (!context.mounted) return;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => SelectFileDialog(
      fileName: fileName,
      fileType: fileType,
      fileSize: readableSize,
      fileExtension: fileExtension,
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
