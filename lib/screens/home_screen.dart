import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:th_pronounce_app/widget/level_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: SvgPicture.asset(
            "assets/images/home_logo.svg",
            width: 114,
            height: 66,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                LevelCard(
                  title: "단어",
                  description: "기초 발음을 위한 단어 연습",
                  level: 1,
                  count: 30, // TODO 추후 해당 데이터의 length 로 변경
                ),
                SizedBox(height: 24),
                LevelCard(
                  title: "짧은 문장",
                  description: "일상 표현으로 발음 다듬기",
                  level: 2,
                  count: 25,
                ),
                SizedBox(height: 24),
                LevelCard(
                  title: "긴 문장",
                  description: "복잡한 문장으로 실력 완성",
                  level: 3,
                  count: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
