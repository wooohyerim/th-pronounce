import 'package:http/http.dart' as http;
import 'package:th_pronounce_app/model/result_model.dart';
import 'dart:convert';
import 'dart:io';

import 'config_service.dart';

class AzureSpeechService {
  String get apiKey => ConfigService.azureSpeechKey;
  String get region => ConfigService.azureSpeechRegion;

  Future<ResultModel> analyzePronunciation({
    required String audioPath,
    required String referenceText,
  }) async {
    try {
      print('Azure Speech 분석 시작');
      print('오디오 파일: $audioPath');
      print('참조 텍스트: $referenceText');

      // API Key 확인
      if (apiKey.isEmpty) {
        throw Exception('Azure API Key가 설정되지 않았습니다');
      }

      // 오디오 파일 읽기
      final audioFile = File(audioPath);
      if (!await audioFile.exists()) {
        throw Exception('오디오 파일을 찾을 수 없습니다');
      }

      final audioBytes = await audioFile.readAsBytes();
      print('오디오 크기: ${audioBytes.length} bytes');

      final pronunciationConfig = {
        "referenceText": referenceText,
        "gradingSystem": "HundredMark",
        "granularity": "Phoneme",
        "dimension": "Comprehensive",
        "enableMiscue": false,
      };

      final pronunciationParamJson = json.encode(pronunciationConfig);
      final pronunciationParamBase64 = base64.encode(
        utf8.encode(pronunciationParamJson),
      );

      // API URL
      final url = Uri.parse(
        'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1'
        '?language=ko-KR'
        '&format=detailed',
      );

      print('API URL: $url');

      // API 호출
      final response = await http.post(
        url,
        headers: {
          'Ocp-Apim-Subscription-Key': apiKey,
          'Content-Type': 'audio/wav; codecs=audio/pcm; samplerate=16000',
          'Accept': 'application/json',
          'Pronunciation-Assessment': pronunciationParamBase64,
        },
        body: audioBytes,
      );

      print('응답 코드: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Azure 분석 성공');
        print('응답: ${json.encode(jsonResponse)}');

        // ResultModel로 변환
        return ResultModel.fromJson(jsonResponse);
      } else {
        print('API 호출 실패');
        print('상태 코드: ${response.statusCode}');
        print('응답: ${response.body}');
        throw Exception('API 호출 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('Azure Speech 에러: $e');
      rethrow;
    }
  }
}
