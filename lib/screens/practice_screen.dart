import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:th_pronounce_app/widget/button.dart';

class PracticeScreen extends StatelessWidget {
  final int level, count;

  const PracticeScreen({super.key, required this.level, required this.count});

  @override
  Widget build(BuildContext context) {
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
                  "1/$count",
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
                    percent: 0,
                    backgroundColor: Color(0xFFF0F0F0),
                    progressColor: Color(0xFF667EEA),
                    barRadius: Radius.circular(8),
                  );
                },
              ),
            ),
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Color(0xFFE8EAF6),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              width: double.infinity,
              height: 220,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "사과",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.w500),
                ),
              ),
            ),
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
                  borderColor: Colors.transparent,
                  textColor: Color(0xFF667EEA),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
