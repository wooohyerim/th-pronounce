import 'package:flutter/material.dart';
import 'package:th_pronounce_app/widget/button.dart';

class AnalyzingButton extends StatelessWidget {
  const AnalyzingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      text: "분석 중...",
      onTap: null, // 비활성화
      icon: Icons.hourglass_empty,
      bgColor: Colors.grey,
      textColor: Colors.white,
    );
  }
}
