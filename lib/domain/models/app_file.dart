import '../../presentation/home/common/file_picker_with_preview.dart';

class AppFile {
  final String name;
  final String path;
  final AppFileType type;

  AppFile({required this.name, required this.path, required this.type});
}
