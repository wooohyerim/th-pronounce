import 'package:flutter/material.dart';
import 'package:th_pronounce_app/widget/practice_screen/analyzing_button.dart';
import 'package:th_pronounce_app/widget/practice_screen/start_button.dart';
import 'package:th_pronounce_app/widget/practice_screen/stop_button.dart';

class RecordingButton extends StatelessWidget {
  final bool isRecording;
  final bool isAnalyzing;
  final VoidCallback onStart;
  final VoidCallback onStop;

  const RecordingButton({
    super.key,
    required this.isRecording,
    required this.isAnalyzing,
    required this.onStart,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    if (isRecording) {
      return StopButton(onStop: onStop);
    }

    if (isAnalyzing) {
      return AnalyzingButton();
    }

    return StartButton(onStart: onStart);
  }
}
