import 'package:flutter/material.dart';
import 'package:th_pronounce_app/service/stats_service.dart';

class StatsPreview extends StatefulWidget {
  const StatsPreview({super.key});

  @override
  State<StatsPreview> createState() => StatsPreviewState();
}

class StatsPreviewState extends State<StatsPreview> {
  final statsService = StatsService();

  int todayCount = 0;
  int averageScore = 0;
  int practiceDays = 0;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    final count = await statsService.getTodayCount();
    final avgScore = await statsService.getAverageScore();
    final days = await statsService.getPracticeDays();

    if (!mounted) return;

    setState(() {
      todayCount = count;
      averageScore = avgScore;
      practiceDays = days;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE8EAF6)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF667EEA).withAlpha(20),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildHeader(), SizedBox(height: 10), buildStats()],
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF667EEA).withAlpha(30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.emoji_events, size: 20, color: Color(0xFF667EEA)),
        ),
        SizedBox(width: 8),
        Text(
          "오늘의 학습",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildStat("연습", "$todayCount회"),
        buildDivider(),
        buildStat("평균 점수", "$averageScore점"),
        buildDivider(),
        buildStat("연습 일수", "$practiceDays일"),
      ],
    );
  }

  Widget buildStat(String label, String value) {
    return Column(
      children: [
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
      ],
    );
  }

  Widget buildDivider() {
    return Container(width: 1, height: 40, color: Color(0xFFE8EAF6));
  }
}
