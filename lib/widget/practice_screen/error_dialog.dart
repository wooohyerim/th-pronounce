import 'package:flutter/material.dart';
import 'package:th_pronounce_app/service/azure_speech_service.dart';

class ErrorDialog extends StatelessWidget {
  final Exception error;

  const ErrorDialog({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final errorInfo = getErrorInfo(error);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔥 아이콘
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: errorInfo.color.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(errorInfo.icon, size: 32, color: errorInfo.color),
            ),
            SizedBox(height: 20),

            // 🔥 타이틀
            Text(
              errorInfo.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 12),

            // 🔥 메시지
            Text(
              errorInfo.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),

            // 🔥 확인 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF667EEA),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "확인",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 에러 종류별 정보 반환
  ErrorInfo getErrorInfo(Exception error) {
    final errorString = error.toString().toLowerCase();

    // 관련 없는 발음
    if (error is IrrelevantSpeechException) {
      return ErrorInfo(
        title: "앗!",
        message: "주어진 단어나 문장을\n말해주세요.",
        icon: Icons.record_voice_over_rounded,
        color: Color(0xFFFF6B6B),
      );
    }

    if (errorString.contains('socketexception') ||
        errorString.contains('failed host lookup') ||
        errorString.contains('network') ||
        errorString.contains('connection') ||
        errorString.contains('clientexception') ||
        errorString.contains('timeout') ||
        errorString.contains('api') ||
        errorString.contains('네트워크')) {
      return ErrorInfo(
        title: "네트워크 오류",
        message: "인터넷 연결을 확인해주세요.\nWi-Fi 또는 데이터를 켜고\n다시 시도해주세요.",
        icon: Icons.wifi_off_rounded,
        color: Color(0xFFFF6B6B),
      );
    }

    // 음성 인식 실패
    if (errorString.contains('음성을 인식') || errorString.contains('nbest')) {
      return ErrorInfo(
        title: "다시 한 번!",
        message: "음성을 인식하지 못했습니다.\n더 크게, 명확하게 발음해주세요.",
        icon: Icons.mic_off_rounded,
        color: Color(0xFFFFA726),
      );
    }

    // 권한 에러
    if (errorString.contains('권한')) {
      return ErrorInfo(
        title: "권한 필요",
        message: "마이크 권한이 필요합니다.\n설정에서 권한을 허용해주세요.",
        icon: Icons.lock_outline_rounded,
        color: Color(0xFFFFA726),
      );
    }

    // 녹음 실패
    if (errorString.contains('녹음')) {
      return ErrorInfo(
        title: "녹음 실패",
        message: "녹음된 음성이 없습니다.\n다시 시도해주세요.",
        icon: Icons.mic_none_rounded,
        color: Color(0xFFFFA726),
      );
    }

    // 기본 에러
    return ErrorInfo(
      title: "앗!",
      message: "분석에 실패했습니다.\n잠시 후 다시 시도해주세요.",
      icon: Icons.error_outline_rounded,
      color: Color(0xFF667EEA),
    );
  }
}

class ErrorInfo {
  final String title, message;
  final IconData icon;
  final Color color;

  const ErrorInfo({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
  });
}
