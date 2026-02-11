import 'package:flutter/material.dart';
import 'package:th_pronounce_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '-th 발음 교정 앱', home: HomeScreen());
  }
}
