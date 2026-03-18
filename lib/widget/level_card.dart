import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final String title, description;
  final int level, count;
  final int progress;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.title,
    required this.description,
    required this.level,
    required this.count,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = calculatePercentage();
    final hasProgress = progress > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            style: BorderStyle.solid,
            color: Color(0xFFE8EAF6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(hasProgress, percentage),
              SizedBox(height: 8),
              buildDescription(),
            ],
          ),
        ),
      ),
    );
  }

  // 퍼센테지 계산
  int calculatePercentage() {
    if (count <= 0) {
      return 0;
    }
    return (progress / count * 100).toInt();
  }

  // 헤더 (타이틀 + 개수 or 퍼센테지)
  Widget buildHeader(bool hasProgress, int percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (hasProgress) buildProgressInfo(percentage),
        if (!hasProgress) buildCountBadge(),
      ],
    );
  }

  // 진행도 정보 (퍼센테지 + 개수)
  Widget buildProgressInfo(int percentage) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$progress/$count",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF999999),
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFF667EEA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "$percentage%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // 퍼센테지 뱃지 (진행도 있을 때)
  // Widget buildPercentageBadge(int percentage) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  //     decoration: BoxDecoration(
  //       color: Color(0xFF667EEA).withAlpha(150),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Text(
  //       "$percentage%",
  //       style: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

  // 개수 뱃지 (진행도 없을 때)
  Widget buildCountBadge() {
    return Text(
      "$count개",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF667EEA),
      ),
    );
  }

  // Widget buildProgressCount(bool hasProgress) {
  //   if (hasProgress) {
  //     return Text(
  //       "$progress/$count", // 🔥 2/35
  //       style: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w600,
  //         color: Color(0xFF667EEA),
  //       ),
  //     );
  //   }

  //   return Text(
  //     "$count개",
  //     style: TextStyle(
  //       fontSize: 16,
  //       fontWeight: FontWeight.bold,
  //       color: Color(0xFF667EEA),
  //     ),
  //   );
  // }

  // 설명
  Widget buildDescription() {
    return Text(
      description,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF888888),
      ),
    );
  }
}
