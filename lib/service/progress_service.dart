import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const String keyWordProgress = 'word_progress';
  static const String keySentenceProgress = 'sentence_progress';

  // 단어 진행도 저장
  Future<void> saveWordProgress(int level, int index) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${keyWordProgress}_level_$level';
    await prefs.setInt(key, index);
    print('💾 단어 진행도 저장: 레벨 $level, 인덱스 $index');
  }

  // 단어 진행도 불러오기
  Future<int> getWordProgress(int level) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${keyWordProgress}_level_$level';
    final progress = prefs.getInt(key);

    if (progress == null) {
      return 0;
    }

    print('📂 단어 진행도 불러오기: 레벨 $level, 인덱스 $progress');
    return progress;
  }

  // 문장 진행도 저장
  Future<void> saveSentenceProgress(int level, int index) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${keySentenceProgress}_level_$level';
    await prefs.setInt(key, index);
    print('💾 문장 진행도 저장: 레벨 $level, 인덱스 $index');
  }

  // 문장 진행도 불러오기
  Future<int> getSentenceProgress(int level) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${keySentenceProgress}_level_$level';
    final progress = prefs.getInt(key);

    if (progress == null) {
      return 0;
    }

    print('📂 문장 진행도 불러오기: 레벨 $level, 인덱스 $progress');
    return progress;
  }

  // 특정 레벨 진행도 초기화
  Future<void> resetLevelProgress(int level, bool isWord) async {
    final prefs = await SharedPreferences.getInstance();

    String key;
    if (isWord) {
      key = '${keyWordProgress}_level_$level';
    } else {
      key = '${keySentenceProgress}_level_$level';
    }

    await prefs.remove(key);

    final type = isWord ? "단어" : "문장";
    print('🗑️ 레벨 $level $type 진행도 초기화');
  }
}
