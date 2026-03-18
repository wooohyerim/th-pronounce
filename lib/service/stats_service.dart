import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const String keyTodayCount = 'today_count';
  static const String keyTodayDate = 'today_date';
  static const String keyTotalScores = 'total_scores';
  static const String keyPracticeDays = 'practice_days';

  // 오늘 연습 횟수 증가
  Future<void> incrementTodayCount() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayString();
    final savedDate = prefs.getString(keyTodayDate);

    // 날짜가 바뀌면 리셋
    if (savedDate != today) {
      await prefs.setString(keyTodayDate, today);
      await prefs.setInt(keyTodayCount, 1);

      // 연습 일수 증가
      await _incrementPracticeDays();
      return;
    }

    // 같은 날이면 증가
    final count = prefs.getInt(keyTodayCount) ?? 0;
    await prefs.setInt(keyTodayCount, count + 1);
  }

  // 오늘 연습 횟수 조회
  Future<int> getTodayCount() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayString();
    final savedDate = prefs.getString(keyTodayDate);

    // 날짜가 다르면 0
    if (savedDate != today) {
      return 0;
    }

    return prefs.getInt(keyTodayCount) ?? 0;
  }

  // 점수 저장 및 평균 계산
  Future<void> saveScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final scores = prefs.getStringList(keyTotalScores) ?? [];

    scores.add(score.toString());

    // 최근 100개만 유지 (너무 많아지지 않게)
    if (scores.length > 100) {
      scores.removeAt(0);
    }

    await prefs.setStringList(keyTotalScores, scores);
  }

  // 평균 점수 조회
  Future<int> getAverageScore() async {
    final prefs = await SharedPreferences.getInstance();
    final scores = prefs.getStringList(keyTotalScores) ?? [];

    if (scores.isEmpty) {
      return 0;
    }

    final total = scores.fold<int>(0, (sum, score) => sum + int.parse(score));

    return (total / scores.length).round();
  }

  // 연습 일수 증가
  Future<void> _incrementPracticeDays() async {
    final prefs = await SharedPreferences.getInstance();
    final days = prefs.getInt(keyPracticeDays) ?? 0;
    await prefs.setInt(keyPracticeDays, days + 1);
  }

  // 연습 일수 조회
  Future<int> getPracticeDays() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyPracticeDays) ?? 0;
  }

  // 오늘 날짜 문자열
  String _getTodayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}
