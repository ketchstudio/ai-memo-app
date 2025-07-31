import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../theme/app_border_radius.dart';
import '../common/file_picker_with_preview.dart';

void showVoiceRecorderDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => VoiceRecorderWidget(),
  );
}

class VoiceRecorderWidget extends StatefulWidget {
  const VoiceRecorderWidget({super.key});

  @override
  State<VoiceRecorderWidget> createState() => _VoiceRecorderWidgetState();
}

class _VoiceRecorderWidgetState extends State<VoiceRecorderWidget> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecorderReady = false;
  bool _isRecording = false;
  bool _isPaused = false;
  String? _filePath;
  Duration _duration = Duration.zero;
  late final Stopwatch _stopwatch;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _ticker = Ticker((_) {
      if (mounted) {
        setState(() {
          _duration = _stopwatch.elapsed;
        });
      }
    });
    initRecorder();
  }

  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
    _isRecorderReady = true;
    setState(() {});
  }

  Future<void> startRecording() async {
    if (!_isRecorderReady) return;
    _stopwatch.reset();
    final dir = await getTemporaryDirectory();
    _filePath = '${dir.path}/voice_note.aac';
    await _recorder.startRecorder(toFile: _filePath, codec: Codec.aacADTS);
    _stopwatch.start();
    _ticker.start();
    setState(() {
      _isRecording = true;
      _isPaused = false;
    });
  }

  Future<void> pauseRecording() async {
    if (!_isRecorderReady || !_isRecording) return;
    await _recorder.pauseRecorder();
    _stopwatch.stop();
    _ticker.stop();
    setState(() {
      _isPaused = true;
    });
  }

  Future<void> resumeRecording() async {
    if (!_isRecorderReady || !_isRecording) return;
    await _recorder.resumeRecorder();
    _stopwatch.start();
    _ticker.start();
    setState(() {
      _isPaused = false;
    });
  }

  Future<void> stopRecording() async {
    if (!_isRecorderReady || !_isRecording) return;
    await _recorder.stopRecorder();
    _stopwatch.stop();
    _ticker.stop();
    setState(() {
      _isRecording = false;
      _isPaused = false;
    });
    if (_filePath != null) {
      showFilePreview(context, _filePath!);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _recorder.closeRecorder();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    return d.toString().split('.').first.padLeft(8, "0");
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: onPressed != null ? color : color.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      constraints: const BoxConstraints.tightFor(width: 56, height: 56),
      child: Icon(
        icon,
        color: Colors.white.withValues(alpha: onPressed != null ? 1.0 : 0.4),
        size: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppBorderRadius.card,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.mic, color: Colors.redAccent, size: 48),
            const SizedBox(height: 8),
            const Text(
              'Recording...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Speak now to record your voice note',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              _formatDuration(_duration),
              style: const TextStyle(fontSize: 28, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircleButton(
                  icon: _isPaused ? Icons.play_arrow : Icons.mic,
                  color: Colors.green,
                  onPressed: _isRecording
                      ? (_isPaused ? resumeRecording : null)
                      : startRecording,
                ),

                // Pause
                _buildCircleButton(
                  icon: Icons.pause,
                  color: Colors.amber,
                  onPressed: (_isRecording && !_isPaused)
                      ? pauseRecording
                      : null,
                ),

                // Stop
                _buildCircleButton(
                  icon: Icons.stop,
                  color: Colors.red,
                  onPressed: _isRecording || _isPaused ? stopRecording : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showFilePreview(BuildContext context, String path) async {
  final info = await getFileInfo(path);
  if (!context.mounted) return;

  if (info == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("File does not exist.")));
    return;
  }

  final fileExtension = path.split('.').last.toLowerCase();
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => SelectFileDialog(
      fileName: info['name'] ?? 'unknown_file',
      fileType: AppFileType.audio,
      fileSize: info['size'] ?? '0 B',
      fileExtension: fileExtension,
      path: path,
    ),
  );
}

Future<Map<String, String>?> getFileInfo(String filePath) async {
  final file = File(filePath);

  if (!await file.exists()) return null;

  final fileName = p.basename(file.path);
  final fileSize = await file.length();
  final readableSize = formatBytes(fileSize);

  return {'name': fileName, 'size': readableSize};
}
