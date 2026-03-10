import 'package:flutter/material.dart';
import 'package:th_pronounce_app/widget/button.dart';

class StopButton extends StatelessWidget {
  final VoidCallback onStop;

  const StopButton({super.key, required this.onStop});

  @override
  Widget build(BuildContext context) {
    return Button(
      text: "녹음 중지",
      onTap: onStop,
      bgColor: Color(0xFFEF4444),
      textColor: Colors.white,
      icon: Icons.stop_circle,
    );
  }
}
