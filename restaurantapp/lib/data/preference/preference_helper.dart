import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static const dartTheme = 'DARK_THEME';
  static const dailyNotification = 'DAILY_NOTIF';

  final Future<SharedPreferences> sharedPreferences;
  PreferenceHelper({required this.sharedPreferences});

  /// for dark theme
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dartTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dartTheme, value);
  }

  /// for notification
  Future<bool> get isDailyNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyNotification) ?? false;
  }

  void setDailyNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyNotification, value);
  }
}
