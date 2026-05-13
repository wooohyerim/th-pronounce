import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:th_pronounce_app/model/result_model.dart';
import 'package:th_pronounce_app/widget/button.dart';
import 'package:th_pronounce_app/widget/percent_box.dart';

class ResultScreen extends StatelessWidget {
  final ResultModel result;
  final String word;
  final int currentIndex, totalCount;
  final VoidCallback onNext;

  const ResultScreen({
    super.key,
    required this.result,
    required this.word,
    required this.currentIndex,
    required this.totalCount,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: Color(0xFFE8EAF6),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "RESULT",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF999999),
                          ),
                        ),
                        SizedBox(height: 8),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return CircularPercentIndicator(
                              radius: 100.0,
                              lineWidth: 15.0,
                              animation: true,
                              percent: result.score / 100,
                              center: Text(
                                "${result.score}점",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: result.getScoreColor(),
                            );
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          result.getFeedback(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          result.getFeedbackDetail(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF888888),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: PercentBox(
                                title: "정확도",
                                percentScore: "${result.accuracy}",
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: PercentBox(
                                title: "유창성",
                                percentScore: "${result.fluency}",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Button(
                  text: "다음 단어",
                  bgColor: Color(0xFF667EEA),
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pop(context);
                    Future.microtask(() => onNext());
                  },
                ),
                SizedBox(height: 12),
                Button(
                  text: "다시 하기",
                  bgColor: Colors.white,
                  borderColor: Color(0xFF667EEA),
                  textColor: Color(0xFF667EEA),
                  icon: Icons.refresh_outlined,
                  iconColor: Color(0xFF667EEA),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 28),
                Button(
                  text: "홈으로",
                  bgColor: Colors.transparent,
                  textColor: Color(0xFF999999),
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
