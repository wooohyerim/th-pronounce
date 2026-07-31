import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:th_pronounce_app/firebase_options.dart';
import 'package:th_pronounce_app/screens/home_screen.dart';
import 'package:th_pronounce_app/service/config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Firebase 초기화
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Remote Config 초기화
    await ConfigService.initialize();

    if (!ConfigService.isConfigured) {
      print('Azure API Key가 설정되지 않았습니다!');
    }
  } catch (e) {
    print(e);
    print("오프 모드 실행");
  }

  print('runApp 시작');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      title: '-th 발음 교정 앱',
      home: HomeScreen(),
    );
  }
}
