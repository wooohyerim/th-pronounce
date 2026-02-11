import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:th_pronounce_app/widget/button.dart';
import 'package:th_pronounce_app/widget/percent_box.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                            percent: score / 100,
                            center: Text(
                              "$score점",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Color(0xFF667EEA),
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        "api 응답 값",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "응답 값 부연 설명",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF888888),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PercentBox(title: "정확도", percentScore: 90),
                          PercentBox(title: "유창성", percentScore: 80),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Button(
                text: "발음 하기",
                bgColor: Color(0xFF667EEA),
                borderColor: Colors.transparent,
                textColor: Colors.white,
              ),
              SizedBox(height: 12),
              Button(
                text: "다시 하기",
                bgColor: Colors.white,
                borderColor: Color(0xFF667EEA),
                textColor: Color(0xFF667EEA),
                icon: Icons.refresh_outlined,
                iconColor: Color(0xFF667EEA),
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
    );
  }
}
