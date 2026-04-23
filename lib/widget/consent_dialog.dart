import 'package:flutter/material.dart';
import 'package:th_pronounce_app/service/consent_service.dart';

class ConsentDialog extends StatelessWidget {
  const ConsentDialog({super.key});

  static Future<void> showIfNeeded(BuildContext context) async {
    final agreed = await ConsentService.hasAgreed();
    if (agreed) return;
    if (!context.mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ConsentDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Color(0xFF667EEA).withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.privacy_tip_rounded,
                size: 32,
                color: Color(0xFF667EEA),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '발음 분석 안내',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 12),
            Text(
              '더 정확한 발음 교정을 위해 녹음된 음성이 Microsoft Azure Speech API로 전송됩니다.\n\n'
              '• 전송 데이터: 녹음된 음성\n'
              '• 수신자: Microsoft Azure\n'
              '• 음성은 분석 후 즉시 삭제되며 저장되지 않습니다',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                height: 1.6,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _onDecline(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('거부', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onAgree(context),
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
                      '동의',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAgree(BuildContext context) async {
    await ConsentService.setAgreed();
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  void _onDecline(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('앱 사용 불가'),
        content: Text('발음 분석을 위해 동의가 필요합니다.\n동의하지 않으면 앱을 사용할 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}
