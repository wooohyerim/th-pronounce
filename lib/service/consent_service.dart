import 'package:shared_preferences/shared_preferences.dart';

class ConsentService {
  static const _key = 'data_consent_agreed';

  static Future<bool> hasAgreed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  static Future<void> setAgreed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
