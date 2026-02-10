import 'package:th_pronounce_app/model/word_data_model.dart';

final List<Map<String, dynamic>> shortSentenceJson = [
  {"id": 1, "text": "서울에 살아요", "levelCategory": "short"},
  {"id": 2, "text": "스마트폰을 써요", "levelCategory": "short"},
  {"id": 3, "text": "스웨터를 입어요", "levelCategory": "short"},
  {"id": 4, "text": "슬리퍼를 신어요", "levelCategory": "short"},
  {"id": 5, "text": "소설책을 읽어요", "levelCategory": "short"},
  {"id": 6, "text": "샐러드를 만들어요", "levelCategory": "short"},
  {"id": 7, "text": "서운해요", "levelCategory": "short"},
  {"id": 8, "text": "설레요", "levelCategory": "short"},
  {"id": 9, "text": "쇼핑을 가요", "levelCategory": "short"},
  {"id": 10, "text": "수영을 해요", "levelCategory": "short"},
  {"id": 11, "text": "스케줄을 세워요", "levelCategory": "short"},
  {"id": 12, "text": "스티커를 사요", "levelCategory": "short"},
  {"id": 13, "text": "스낵을 샀어요", "levelCategory": "short"},
  {"id": 14, "text": "사전을 찾아요", "levelCategory": "short"},
  {"id": 15, "text": "선생님께 인사해요", "levelCategory": "short"},
  {"id": 16, "text": "스프를 식혀요", "levelCategory": "short"},
  {"id": 17, "text": "샌드위치를 썰어요", "levelCategory": "short"},
  {"id": 18, "text": "소스를 섞어요", "levelCategory": "short"},
  {"id": 19, "text": "속상해서 울어요", "levelCategory": "short"},
  {"id": 20, "text": "수건으로 손을 닦아요", "levelCategory": "short"},
  {"id": 21, "text": "선생님이 수업을 시작해요", "levelCategory": "short"},
  {"id": 22, "text": "스테이크에 소금을 살짝 뿌려요", "levelCategory": "short"},
  {"id": 23, "text": "세탁소에서 옷을 찾았어요", "levelCategory": "short"},
  {"id": 24, "text": "스키장에서 친구들과 썰매를 타요", "levelCategory": "short"},
  {"id": 25, "text": "수영장에서 신나게 수영했어요", "levelCategory": "short"},
];

List<WordDataModel> get shortSentence =>
    shortSentenceJson.map((data) => WordDataModel.fromJson(data)).toList();
