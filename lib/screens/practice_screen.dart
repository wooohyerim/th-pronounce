import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:th_pronounce_app/data/all_data.dart';
import 'package:th_pronounce_app/model/word_data_model.dart';
import 'package:th_pronounce_app/screens/result_screen.dart';
import 'package:th_pronounce_app/widget/button.dart';
import 'package:th_pronounce_app/widget/word_card.dart';

class PracticeScreen extends StatefulWidget {
  final int level;

  const PracticeScreen({super.key, required this.level});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late List<WordDataModel> wordList;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    wordList = AllWordData.getDataByLevel(widget.level);
  }

  @override
  Widget build(BuildContext context) {
    final currentWord = wordList[currentIndex];
    final progressValue = (currentIndex + 1) / wordList.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Stack(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
                iconSize: 20,
              ),
              Center(
                child: SvgPicture.asset(
                  "assets/images/page_logo.svg",
                  width: 60,
                  height: 45,
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${currentIndex + 1} / ${wordList.length}",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Color(0xFFE8EAF6),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return LinearPercentIndicator(
                    width: constraints.maxWidth,
                    lineHeight: 6,
                    percent: progressValue,
                    backgroundColor: Color(0xFFF0F0F0),
                    progressColor: Color(0xFF667EEA),
                    barRadius: Radius.circular(8),
                  );
                },
              ),
            ),
            SizedBox(height: 50),
            WordCard(text: currentWord.text, level: widget.level),
            SizedBox(height: 45),
            Column(
              children: [
                Button(
                  text: "발음 듣기",
                  bgColor: Colors.white,
                  borderColor: Color(0xFFE8EAF6),
                  textColor: Color(0xFF667EEA),
                ),
                SizedBox(height: 16),
                Button(
                  text: "발음 하기",
                  bgColor: Color(0xFFE8EAF6),
                  textColor: Color(0xFF667EEA),
                ),
                Button(
                  text: "결과페이지",
                  bgColor: Color(0xFFE8EAF6),
                  textColor: Color(0xFF667EEA),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(score: 80),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
