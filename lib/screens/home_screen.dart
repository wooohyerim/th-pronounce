import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:th_pronounce_app/data/all_data.dart';
import 'package:th_pronounce_app/screens/practice_screen.dart';
import 'package:th_pronounce_app/service/progress_service.dart';
import 'package:th_pronounce_app/widget/consent_dialog.dart';
import 'package:th_pronounce_app/widget/level_card.dart';
import 'package:th_pronounce_app/widget/stats_preview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final progressService = ProgressService();
  final Map<int, int> wordProgress = {};
  final statsKey = GlobalKey<StatsPreviewState>();

  @override
  void initState() {
    super.initState();
    loadAllProgress();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConsentDialog.showIfNeeded(context);
    });
  }

  // 모든 레벨 진행도 불러오기
  Future<void> loadAllProgress() async {
    final results = await Future.wait([
      progressService.getWordProgress(1),
      progressService.getWordProgress(2),
      progressService.getWordProgress(3),
    ]);

    if (!mounted) return;

    setState(() {
      wordProgress[1] = results[0];
      wordProgress[2] = results[1];
      wordProgress[3] = results[2];
    });
  }

  // 레벨 선택 후 돌아왔을 때 진행도 새로고침
  Future<void> navigateToPractice(int level) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PracticeScreen(level: level)),
    );

    if (!mounted) return;

    loadAllProgress();

    statsKey.currentState?.loadStats();
  }

  @override
  Widget build(BuildContext context) {
    final wordLength = AllWordData.getDataByLevel(1).length;
    final shortLength = AllWordData.getDataByLevel(2).length;
    final longLength = AllWordData.getDataByLevel(3).length;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "PRACTICE LEVELS",
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 18),
                LevelCard(
                  title: "단어",
                  description: "기초 발음을 위한 단어 연습",
                  level: 1,
                  count: wordLength,
                  progress: wordProgress[1] ?? 0,
                  onTap: () => navigateToPractice(1),
                ),
                SizedBox(height: 24),
                LevelCard(
                  title: "짧은 문장",
                  description: "일상 표현으로 발음 다듬기",
                  level: 2,
                  count: shortLength,
                  progress: wordProgress[2] ?? 0,
                  onTap: () => navigateToPractice(2),
                ),
                SizedBox(height: 24),
                LevelCard(
                  title: "긴 문장",
                  description: "복잡한 문장으로 실력 완성",
                  level: 3,
                  count: longLength,
                  progress: wordProgress[3] ?? 0,
                  onTap: () => navigateToPractice(3),
                ),
                SizedBox(height: 40),
                StatsPreview(key: statsKey),
                // SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
