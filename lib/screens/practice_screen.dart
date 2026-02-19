import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:th_pronounce_app/data/all_data.dart';
import 'package:th_pronounce_app/model/result_model.dart';
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
  bool isRecording = false;
  bool isAnalyzing = false;

  @override
  void initState() {
    super.initState();

    wordList = AllWordData.getDataByLevel(widget.level);
  }

  Future<void> playPronunciation() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("발음 재생: ${wordList[currentIndex].text}"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> recordPronunciation() async {
    setState(() {
      isRecording = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("녹음 중..."),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF667EEA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
      ),
    );

    try {
      await await Future.delayed(Duration(seconds: 3));

      setState(() {
        isRecording = false;
        isAnalyzing = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("분석 중...."),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF667EEA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(16),
        ),
      );

      await Future.delayed(Duration(seconds: 2));

      // 임시 결과
      ResultModel result = ResultModel.random();

      setState(() {
        isAnalyzing = false;
      });

      goToResult(result);
    } catch (e) {
      setState(() {
        isRecording = false;
        isAnalyzing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("에러 발생: $e"), backgroundColor: Colors.red),
      );
    }
  }

  void goToNext() {
    if (!mounted) {
      return;
    }

    if (currentIndex < wordList.length - 1) {
      setState(() {
        currentIndex++;
      });

      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("연습 완료!"),
        content: Text("${wordList.length}개 단어를 모두 완료했어요!🎉"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text("홈으로"),
          ),
        ],
      ),
    );
  }

  void goToResult(ResultModel result) {
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          result: result,
          word: wordList[currentIndex].text,
          currentIndex: currentIndex,
          totalCount: wordList.length,
          onNext: goToNext,
        ),
      ),
    );
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
                  onTap: playPronunciation, // TODO azure API 적용 예정
                ),
                SizedBox(height: 16),
                Button(
                  text: "발음 하기",
                  bgColor: Color(0xFFE8EAF6),
                  textColor: Color(0xFF667EEA),
                  onTap: recordPronunciation, // TODO azure API 적용 예정
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
