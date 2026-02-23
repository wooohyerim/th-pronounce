// lib/services/config_service.dart

import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigService {
  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  // 🔥 초기화
  static Future<void> initialize() async {
    try {
      // Remote Config 설정
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero, // 🔥 개발 중: 즉시 업데이트
        ),
      );

      // 기본값 설정 (네트워크 없을 때 사용)
      await _remoteConfig.setDefaults({
        'azure_speech_key': '',
        'azure_speech_region': 'koreacentral',
      });

      // 🔥 최신 값 가져오기
      await _remoteConfig.fetchAndActivate();

      print('✅ Firebase Remote Config 초기화 완료');
      print('   Azure Key: ${azureSpeechKey.isEmpty ? "❌ 없음" : "✅ 설정됨"}');
      print('   Azure Region: $azureSpeechRegion');
    } catch (e) {
      print('❌ Firebase Remote Config 초기화 실패: $e');
    }
  }

  // 🔥 Azure Speech Key 가져오기
  static String get azureSpeechKey =>
      _remoteConfig.getString('azure_speech_key');

  // 🔥 Azure Region 가져오기
  static String get azureSpeechRegion =>
      _remoteConfig.getString('azure_speech_region');

  // 설정 확인
  static bool get isConfigured => azureSpeechKey.isNotEmpty;
}
