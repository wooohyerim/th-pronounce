import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:th_pronounce_app/firebase_options.dart';
import 'package:th_pronounce_app/screens/home_screen.dart';
import 'package:th_pronounce_app/service/config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('🚀 앱 시작');

  // 🔥 Firebase 초기화
  print('🔥 Firebase 초기화 중...');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('✅ Firebase 초기화 완료');

  // 🔥 Remote Config 초기화
  print('🔧 Remote Config 초기화 중...');
  await ConfigService.initialize();

  if (!ConfigService.isConfigured) {
    print('⚠️ Azure API Key가 설정되지 않았습니다!');
    print('   Firebase Console → Remote Config에서 설정하세요');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '-th 발음 교정 앱', home: HomeScreen());
  }
}
