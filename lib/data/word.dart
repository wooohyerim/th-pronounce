import 'package:th_pronounce_app/model/word_data_model.dart';

final List<Map<String, dynamic>> wordJson = [
  {"id": 1, "text": "사과", "levelCategory": "word"},
  {"id": 2, "text": "소금", "levelCategory": "word"},
  {"id": 3, "text": "수박", "levelCategory": "word"},
  {"id": 4, "text": "설탕", "levelCategory": "word"},
  {"id": 5, "text": "식사", "levelCategory": "word"},
  {"id": 6, "text": "사탕", "levelCategory": "word"},
  {"id": 7, "text": "새우", "levelCategory": "word"},
  {"id": 8, "text": "생선", "levelCategory": "word"},
  {"id": 9, "text": "수프", "levelCategory": "word"},
  {"id": 10, "text": "시금치", "levelCategory": "word"},
  {"id": 11, "text": "시소", "levelCategory": "word"},
  {"id": 12, "text": "손", "levelCategory": "word"},
  {"id": 13, "text": "손가락", "levelCategory": "word"},
  {"id": 14, "text": "손톱", "levelCategory": "word"},
  {"id": 15, "text": "심장", "levelCategory": "word"},
  {"id": 16, "text": "손목", "levelCategory": "word"},
  {"id": 17, "text": "소리", "levelCategory": "word"},
  {"id": 18, "text": "색깔", "levelCategory": "word"},
  {"id": 19, "text": "산책", "levelCategory": "word"},
  {"id": 20, "text": "사진", "levelCategory": "word"},
  {"id": 21, "text": "신발", "levelCategory": "word"},
  {"id": 22, "text": "수건", "levelCategory": "word"},
  {"id": 23, "text": "시계", "levelCategory": "word"},
  {"id": 24, "text": "소파", "levelCategory": "word"},
  {"id": 25, "text": "선생님", "levelCategory": "word"},
  {"id": 26, "text": "손님", "levelCategory": "word"},
  {"id": 27, "text": "학생", "levelCategory": "word"},
  {"id": 28, "text": "사람", "levelCategory": "word"},
  {"id": 29, "text": "삼촌", "levelCategory": "word"},
  {"id": 30, "text": "사랑", "levelCategory": "word"},
  {"id": 31, "text": "생각", "levelCategory": "word"},
  {"id": 32, "text": "생강", "levelCategory": "word"},
  {"id": 33, "text": "시선", "levelCategory": "word"},
  {"id": 34, "text": "숫사슴", "levelCategory": "word"},
  {"id": 35, "text": "세수", "levelCategory": "word"},
];

// 내부에 있는 데이터를 불러올 때
// 외부 api 호출해서 불러올 경우 Future 적용

List<WordDataModel> get words =>
    wordJson.map((data) => WordDataModel.fromJson(data)).toList();
