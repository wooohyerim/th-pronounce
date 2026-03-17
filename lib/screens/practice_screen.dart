import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:th_pronounce_app/data/all_data.dart';
import 'package:th_pronounce_app/model/result_model.dart';
import 'package:th_pronounce_app/model/word_data_model.dart';
import 'package:th_pronounce_app/screens/result_screen.dart';
import 'package:th_pronounce_app/service/azure_speech_service.dart';
import 'package:th_pronounce_app/service/progress_service.dart';
import 'package:th_pronounce_app/service/recording_service.dart';
import 'package:th_pronounce_app/service/tts_service.dart';
import 'package:th_pronounce_app/widget/button.dart';
import 'package:th_pronounce_app/widget/practice_screen/complete_dialog.dart';
import 'package:th_pronounce_app/widget/practice_screen/error_dialog.dart';
import 'package:th_pronounce_app/widget/practice_screen/recording_button.dart';
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
  bool isPlaying = false;

  final RecordingService recordingService = RecordingService();
  final AzureSpeechService azureSpeechService = AzureSpeechService();
  final TtsService ttsService = TtsService();
  final ProgressService progressService = ProgressService();

  @override
  void initState() {
    super.initState();

    wordList = AllWordData.getDataByLevel(widget.level);
    ttsService.initialize();
    loadProgress();
  }

  // 진행도 불러오기
  Future<void> loadProgress() async {
    final progress = await progressService.getWordProgress(widget.level);

    if (progress >= wordList.length) {
      return;
    }

    if (progress <= 0) {
      return;
    }

    if (!mounted) return;

    setState(() {
      currentIndex = progress;
    });
  }

  @override
  void dispose() {
    recordingService.dispose();
    ttsService.dispose();
    super.dispose();
  }

  Future<void> playPronunciation() async {
    if (isPlaying) return; // 이미 재생 중이면 무시

    setState(() {
      isPlaying = true;
    });

    try {
      await ttsService.speak(wordList[currentIndex].text, level: widget.level);

      // 재생 완료 후 딜레이
      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        isPlaying = false;
      });
    } catch (e) {
      setState(() {
        isPlaying = false;
      });
      showErrorSnackBar("발음 재생 실패: $e");
    }
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ $message"), backgroundColor: Colors.red),
    );
  }

  // 녹음 시작
  Future<void> startRecording() async {
    setState(() {
      isRecording = true;
    });

    try {
      recordingService.startRecording();
    } catch (e) {
      setState(() {
        isRecording = false;
      });
      showErrorSnackBar("녹음 시작 실패: $e");
    }
  }

  // 녹음 중지 및 분석
  Future<void> stopRecordingAndAnalyze() async {
    try {
      final audioPath = await recordingService.stopRecording();

      if (audioPath == null) {
        setState(() {
          isRecording = false;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("🎤 녹음 실패"),
            content: Text("녹음된 음성이 없습니다.\n다시 시도해주세요."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("확인"),
              ),
            ],
          ),
        );
        return;
      }

      setState(() {
        isRecording = false;
        isAnalyzing = true;
      });

      await analyzeAndShowResult(audioPath);
    } catch (e) {
      setState(() {
        isRecording = false;
        isAnalyzing = false;
      });
      showErrorSnackBar("에러 발생: $e");
    }
  }

  // 분석 결과
  Future<void> analyzeAndShowResult(String audioPath) async {
    try {
      final result = await azureSpeechService.analyzePronunciation(
        audioPath: audioPath,
        referenceText: wordList[currentIndex].text,
      );

      setState(() {
        isAnalyzing = false;
      });

      goToResult(result);
    } catch (e) {
      setState(() {
        isAnalyzing = false;
      });

      showDialog(
        context: context,
        builder: (context) => ErrorDialog(error: e as Exception),
      );
    }
  }

  void goToNext() {
    if (!mounted) {
      return;
    }

    if (currentIndex >= wordList.length - 1) {
      CompleteDialog.show(
        context,
        level: widget.level,
        onRestart: () {
          setState(() {
            currentIndex = 0;
          });
        },
      );
      return;
    }

    setState(() {
      currentIndex++;
    });

    progressService.saveWordProgress(widget.level, currentIndex);
  }

  void goToResult(ResultModel result) async {
    if (!mounted) return;

    await Navigator.push(
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
                  onTap: playPronunciation,
                ),
                SizedBox(height: 16),

                RecordingButton(
                  isRecording: isRecording,
                  isAnalyzing: isAnalyzing,
                  onStart: startRecording,
                  onStop: stopRecordingAndAnalyze,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
