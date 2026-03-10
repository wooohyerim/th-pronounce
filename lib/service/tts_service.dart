import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 한국어 설정
      await _tts.setLanguage("ko-KR");

      // 속도 (0.0 ~ 1.0, 낮을수록 느림)
      await _tts.setSpeechRate(0.4);

      // 볼륨 (0.0 ~ 1.0)
      await _tts.setVolume(1.0);

      // 음높이 (0.5 ~ 2.0)
      await _tts.setPitch(1.0);

      _isInitialized = true;
      print('TTS 초기화 완료');
    } catch (e) {
      print('TTS 초기화 실패: $e');
    }
  }

  Future<void> speak(String text, {int level = 1}) async {
    try {
      await initialize();

      // 레벨별 속도 조정
      final speed = _getSpeechRate(level);
      await _tts.setSpeechRate(speed);

      await _tts.speak(text);
      print('TTS 재생: $text (속도: $speed)');
    } catch (e) {
      print('TTS 재생 실패: $e');
      rethrow;
    }
  }

  // 레벨별 속도 설정
  double _getSpeechRate(int level) {
    switch (level) {
      case 1:
        return 0.6;
      case 2:
        return 0.5;
      case 3:
        return 0.5;
      default:
        return 0.5;
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      print('TTS 중지 실패: $e');
    }
  }

  void dispose() {
    _tts.stop();
  }
}
