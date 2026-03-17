import 'package:flutter/material.dart';

class ResultModel {
  final int score, accuracy, fluency, completeness;
  final String recognizedText;

  ResultModel({
    required this.score,
    required this.accuracy,
    required this.fluency,
    this.completeness = 100,
    this.recognizedText = '',
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    try {
      // NBest 배열에서 첫 번째 결과
      final nBest = json['NBest'] as List<dynamic>?;

      if (nBest == null || nBest.isEmpty) {
        throw Exception('NBest 배열이 비어있습니다');
      }

      final firstResult = nBest[0] as Map<String, dynamic>;

      final accuracyScore =
          (firstResult['AccuracyScore'] as num?)?.round() ?? 0;
      final fluencyScore = (firstResult['FluencyScore'] as num?)?.round() ?? 0;
      final completenessScore =
          (firstResult['CompletenessScore'] as num?)?.round() ?? 100;
      final pronScore = (firstResult['PronScore'] as num?)?.round() ?? 0;

      final recognizedText =
          (firstResult['Display'] as String? ??
                  firstResult['Lexical'] as String? ??
                  '')
              .replaceAll('.', '');

      print('📊 발음 점수:');
      print('   정확도: $accuracyScore');
      print('   유창성: $fluencyScore');
      print('   완성도: $completenessScore');
      print('   종합: $pronScore');
      print('   인식된 텍스트: $recognizedText');

      return ResultModel(
        score: pronScore,
        accuracy: accuracyScore,
        fluency: fluencyScore,
        completeness: completenessScore,
        recognizedText: recognizedText,
      );
    } catch (e) {
      print('❌ ResultModel 변환 실패: $e');
      print('원본 응답: $json');

      throw Exception('음성을 인식하지 못했습니다. 다시 시도해주세요.');
    }
  }

  // 테스트용 점수
  factory ResultModel.random() {
    final score = 70 + (DateTime.now().second % 30);

    return ResultModel(
      score: score,
      accuracy: 75 + (DateTime.now().second % 25),
      fluency: 80 + (DateTime.now().second % 20),
      completeness: 100,
      recognizedText: '테스트',
    );
  }

  String getFeedback() {
    if (score >= 95) return "완벽해요! 🎉";
    if (score >= 85) return "좋아요! 👍";
    if (score >= 75) return "괜찮아요! 😊";
    if (score >= 65) return "조금만 더! 💪";
    return "다시 해봐요! 🔄";
  }

  String getFeedbackDetail() {
    if (score >= 95) return "원어민 수준의 정확한 발음이에요!";
    if (score >= 85) return "매우 정확한 발음입니다\n약간의 억양 차이만 있어요";
    if (score >= 75) return "정확하고 이해 가능한 발음이에요\n계속 연습하면 더 좋아질 거예요";
    if (score >= 65) return "이해 가능한 발음이에요\n눈에 띄는 오류를 고쳐보세요";
    if (score >= 50) return "여러 발음 오류가 있어요\n정답 발음을 여러 번 들어보세요";
    return "발음을 천천히, 정확하게\n한 번 더 시도해보세요";
  }

  Color getScoreColor() {
    if (score >= 85) return Color.fromARGB(255, 11, 171, 30);
    if (score >= 65) return Color.fromARGB(255, 33, 170, 243);
    if (score >= 50) return Color(0xFFFF9800);
    return Color(0xFFFF3B30);
  }

  @override
  String toString() {
    return 'result(score: $score, accuracy: $accuracy, fluency: $fluency, completeness: $completeness, text: $recognizedText)';
  }
}
