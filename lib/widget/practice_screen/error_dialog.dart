import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final Exception error;

  const ErrorDialog({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final errorInfo = getErrorInfo(error);

    return AlertDialog(
      title: Text(errorInfo.title),
      content: Text(errorInfo.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: Color(0xFF667EEA)),
          child: Text("확인"),
        ),
      ],
    );
  }

  // 🔥 에러 종류별 정보 반환
  ErrorInfo getErrorInfo(Exception error) {
    final errorString = error.toString();

    if (errorString.contains('음성을 인식') || errorString.contains('NBest')) {
      return ErrorInfo(
        title: "🎤 다시 한 번!",
        message: "음성을 인식하지 못했습니다.\n\n더 크게, 명확하게 발음해주세요.",
      );
    }

    if (errorString.contains('API') || errorString.contains('네트워크')) {
      return ErrorInfo(title: "📡 네트워크 오류", message: "인터넷 연결을 확인해주세요.");
    }

    if (errorString.contains('권한')) {
      return ErrorInfo(title: "🎤 권한 필요", message: "마이크 권한이 필요합니다.");
    }

    if (errorString.contains('녹음')) {
      return ErrorInfo(
        title: "🎤 녹음 실패",
        message: "녹음된 음성이 없습니다.\n\n다시 시도해주세요.",
      );
    }

    // 기본 에러
    return ErrorInfo(title: "😅 앗!", message: "분석에 실패했습니다.\n다시 시도해주세요.");
  }
}

// 🔥 에러 정보 모델
class ErrorInfo {
  final String title;
  final String message;

  const ErrorInfo({required this.title, required this.message});
}
