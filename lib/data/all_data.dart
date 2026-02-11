import 'package:th_pronounce_app/data/long_sentence.dart';
import 'package:th_pronounce_app/data/short_sentence.dart';
import 'package:th_pronounce_app/data/word.dart';
import 'package:th_pronounce_app/model/word_data_model.dart';

class AllWordData {
  static List<WordDataModel> getDataByLevel(int level) {
    if (level == 1) {
      return words;
    }

    if (level == 2) {
      return shortSentence;
    }

    return longSentence;
  }

  static int getCountByLevel(int level) {
    if (level == 1) {
      return words.length;
    }

    if (level == 2) {
      return shortSentence.length;
    }

    return longSentence.length;
  }
}
