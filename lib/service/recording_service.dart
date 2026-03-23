import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class RecordingService {
  final AudioRecorder _recorder = AudioRecorder();
  String? _recordingPath;

  // 마이크 권한 요청
  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();

    if (status.isPermanentlyDenied) {
      return openAppSettings();
    }

    return status.isGranted;
  }

  // 녹음 시작
  void startRecording() async {
    try {
      if (!await requestPermission()) {
        throw Exception('마이크 권한이 필요합니다');
      }

      final directory = await getApplicationDocumentsDirectory();
      _recordingPath =
          "${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.wav";

      print('녹음 시작');

      await _recorder.start(
        RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: _recordingPath!,
      );
    } catch (e) {
      print('녹음 시작 실패: $e');
    }
  }

  // 녹음 중지 및 파일 경로 반환
  Future<String?> stopRecording() async {
    try {
      final path = await _recorder.stop();
      print('녹음 중지');

      if (path != null) {
        final file = File(path);
        final exists = await file.exists();
        final size = await file.length();
        print('파일 존재: $exists');
        print('파일 크기: $size bytes');

        // 너무 작으면 (< 5KB) 유효하지 않은 녹음
        if (size < 5000) {
          print('녹음 파일이 너무 작음 (빈 녹음)');
          return null;
        }
      }

      return path;
    } catch (e) {
      print('녹음 중지 실패: $e');
      rethrow;
    }
  }

  // 녹음 중인지 확인
  Future<bool> isRecording() async {
    return await _recorder.isRecording();
  }

  void dispose() {
    _recorder.dispose();
  }
}
