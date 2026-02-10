import 'package:th_pronounce_app/model/word_data_model.dart';

final List<Map<String, dynamic>> longSentenceJson = [
  {"id": 1, "text": "서울에서 스마트폰으로 사진을 찍었어요", "levelCategory": "long"},
  {"id": 2, "text": "스웨터를 입고 쇼핑을 다녀왔어요", "levelCategory": "long"},
  {"id": 3, "text": "스케줄을 확인하고 수업 준비를 했어요", "levelCategory": "long"},
  {"id": 4, "text": "슬리퍼를 신고 편하게 쉬었어요", "levelCategory": "long"},
  {"id": 5, "text": "소설책을 읽으며 감동받았습니다", "levelCategory": "long"},
  {"id": 6, "text": "샐러드를 만들어서 식탁에 놓았어요", "levelCategory": "long"},
  {"id": 7, "text": "샌드위치를 싸서 소풍을 갔어요", "levelCategory": "long"},
  {"id": 8, "text": "새로운 사전을 사러 서점에 갔어요", "levelCategory": "long"},
  {"id": 9, "text": "오랜만에 친구를 만나서 반가웠어요", "levelCategory": "long"},
  {"id": 10, "text": "설레는 마음으로 선물을 받았어요", "levelCategory": "long"},
  {"id": 11, "text": "선생님께서 수업 시간에 소설을 소개하셨어요", "levelCategory": "long"},
  {"id": 12, "text": "스테이크에 소스를 뿌리고 샐러드를 곁들였어요", "levelCategory": "long"},
  {"id": 13, "text": "수영장에서 수영하고 사우나에서 쉬었어요", "levelCategory": "long"},
  {"id": 14, "text": "스키장에서 스키를 타다가 넘어졌어요", "levelCategory": "long"},
  {"id": 15, "text": "서점에서 새로운 소설책을 세 권 샀어요", "levelCategory": "long"},
  {"id": 16, "text": "세탁소에 옷을 맡기고 식당에서 식사했어요", "levelCategory": "long"},
  {"id": 17, "text": "친구들과 함께 쇼핑하고 맛있는 간식을 먹었어요", "levelCategory": "long"},
  {"id": 18, "text": "속상한 일이 있었지만 선생님께 상담받았어요", "levelCategory": "long"},
  {"id": 19, "text": "신나는 음악을 들으며 신발을 신고 산책했어요", "levelCategory": "long"},
  {"id": 20, "text": "스크랩북에 사진과 스티커를 예쁘게 붙였어요", "levelCategory": "long"},
];

List<WordDataModel> get words =>
    longSentenceJson.map((data) => WordDataModel.fromJson(data)).toList();
