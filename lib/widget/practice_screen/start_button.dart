import 'package:flutter/material.dart';
import 'package:th_pronounce_app/widget/button.dart';

class StartButton extends StatelessWidget {
  final VoidCallback onStart;

  const StartButton({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Button(
      text: "발음 하기",
      bgColor: Color(0xFFE8EAF6),
      textColor: Color(0xFF667EEA),
      onTap: onStart,
    );
  }
}
