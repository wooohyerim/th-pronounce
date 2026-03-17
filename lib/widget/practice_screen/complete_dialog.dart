// lib/widgets/practice_screen/completion_dialog.dart

import 'package:flutter/material.dart';
import 'package:th_pronounce_app/service/progress_service.dart';

class CompleteDialog extends StatelessWidget {
  final int level;
  final VoidCallback onRestart;

  const CompleteDialog({
    super.key,
    required this.level,
    required this.onRestart,
  });

  static void show(
    BuildContext context, {
    required int level,
    required VoidCallback onRestart,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CompleteDialog(level: level, onRestart: onRestart),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progressService = ProgressService();

    return AlertDialog(
      title: Text("🎉 완료!"),
      content: Text("레벨 $level 단어를\n모두 완료했습니다!", textAlign: TextAlign.center),
      actions: [
        TextButton(
          onPressed: () {
            progressService.resetLevelProgress(level, true);
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          style: TextButton.styleFrom(foregroundColor: Color(0xFF999999)),
          child: Text("홈으로"),
        ),
        TextButton(
          onPressed: () {
            progressService.resetLevelProgress(level, true);
            Navigator.pop(context);
            onRestart();
          },
          style: TextButton.styleFrom(foregroundColor: Color(0xFF667EEA)),
          child: Text("처음부터"),
        ),
      ],
    );
  }
}
