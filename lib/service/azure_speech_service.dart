import 'package:http/http.dart' as http;
import 'package:th_pronounce_app/model/result_model.dart';
import 'dart:convert';
import 'dart:io';

import 'config_service.dart';

class IrrelevantSpeechException implements Exception {}

class AzureSpeechService {
  String get apiKey => ConfigService.azureSpeechKey;
  String get region => ConfigService.azureSpeechRegion;

  Future<ResultModel> analyzePronunciation({
    required String audioPath,
    required String referenceText,
  }) async {
    try {
      if (apiKey.isEmpty) {
        throw Exception('Azure API Key가 설정되지 않았습니다');
      }

      final audioFile = File(audioPath);
      if (!await audioFile.exists()) {
        throw Exception('오디오 파일을 찾을 수 없습니다');
      }

      final audioBytes = await audioFile.readAsBytes();

      final pronunciationConfig = {
        "referenceText": referenceText,
        "gradingSystem": "HundredMark",
        "granularity": "Phoneme",
        "dimension": "Comprehensive",
        "enableMiscue": false,
        "phonemeAlphabet": "IPA",
      };

      final pronunciationParamJson = json.encode(pronunciationConfig);
      final pronunciationParamBase64 = base64.encode(
        utf8.encode(pronunciationParamJson),
      );

      final url = Uri.parse(
        'https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1'
        '?language=ko-KR'
        '&format=detailed',
      );

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
        print('응답: ${json.encode(jsonResponse)}');

        final result = ResultModel.fromJson(jsonResponse);

        // 관련 없는 발음 체크
        if (result.completeness < 30) {
          throw IrrelevantSpeechException();
        }

        final nBest = jsonResponse['NBest'];
        if (nBest == null || nBest is! List || nBest.isEmpty) {
          return result;
        }

        final words = nBest[0]['Words'] as List?;
        if (words == null) {
          return result;
        }

        final hasWrongTh = _checkWrongThPronunciation(words);
        if (!hasWrongTh) {
          return result;
        }

        final originalScore = result.score;
        final penaltyScore = (originalScore * 0.7).toInt();

        print('잘못된 "th" 발음 감지 - 감점 적용: $originalScore → $penaltyScore');

        return ResultModel(
          score: penaltyScore,
          accuracy: result.accuracy,
          fluency: result.fluency,
          completeness: result.completeness,
          recognizedText: result.recognizedText,
          hasThError: true,
        );
      }

      print('응답: ${response.body}');
      throw Exception('API 호출 실패: ${response.statusCode}');
    } catch (e) {
      print('Azure Speech 에러: $e');
      rethrow;
    }
  }

  // 잘못된 "th" 발음 체크
  bool _checkWrongThPronunciation(List words) {
    if (words.isEmpty) {
      return false;
    }

    return words.whereType<Map>().any(_hasThInWord);
  }

  // 단어에 th 발음 있는지 체크
  bool _hasThInWord(Map word) {
    // final wordText = word['Word'] as String? ?? '';

    final phonemes = word['Phonemes'] as List?;
    if (phonemes == null) {
      return false;
    }

    return phonemes.whereType<Map>().any(_isThPhoneme);
  }

  // 음소가 th(θ, ð)인지 체크
  bool _isThPhoneme(Map phoneme) {
    final phone = phoneme['Phoneme'] as String? ?? '';
    final assessment = phoneme['PronunciationAssessment'];
    final score = assessment != null && assessment is Map
        ? assessment['AccuracyScore'] as num?
        : null;

    print('음소: $phone (점수: ${score ?? "N/A"})');

    if (phone == 'θ' || phone == 'ð') {
      print('"th" 발음 감지!');
      return true;
    }

    return false;
  }
}
