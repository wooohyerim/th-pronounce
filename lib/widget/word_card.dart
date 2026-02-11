import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String text;
  final int level;

  const WordCard({super.key, required this.text, required this.level});

  double formatFontSize(int level) {
    if (level == 1) {
      return 56;
    }

    if (level == 2) {
      return 32;
    }

    return 20;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.solid, color: Color(0xFFE8EAF6)),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: formatFontSize(level),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 4,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}
