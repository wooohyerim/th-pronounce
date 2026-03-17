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
    final percentage = _calculatePercentage();
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
              _buildHeader(hasProgress, percentage),
              SizedBox(height: 8),
              _buildDescription(),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 퍼센테지 계산
  int _calculatePercentage() {
    if (count <= 0) {
      return 0;
    }
    return (progress / count * 100).toInt();
  }

  // 헤더 (타이틀 + 개수 or 퍼센테지)
  Widget _buildHeader(bool hasProgress, int percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (hasProgress) _buildPercentageBadge(percentage),
        if (!hasProgress) _buildCountBadge(),
      ],
    );
  }

  // 퍼센테지 뱃지 (진행도 있을 때)
  Widget _buildPercentageBadge(int percentage) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF667EEA).withAlpha(150),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "$percentage%",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // 개수 뱃지 (진행도 없을 때)
  Widget _buildCountBadge() {
    return Text(
      "$count개",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF667EEA),
      ),
    );
  }

  // 설명
  Widget _buildDescription() {
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
