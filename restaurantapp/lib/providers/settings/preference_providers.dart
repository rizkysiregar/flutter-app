import 'package:flutter/material.dart';
import 'package:restaurantapp/common/styles.dart';
import 'package:restaurantapp/data/preference/preference_helper.dart';

class PreferenceProviders extends ChangeNotifier {
  PreferenceHelper preferenceHelper;

  PreferenceProviders({required this.preferenceHelper}) {
    _getTheme();
    _getDailyNotificationPreference();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  bool _isDailyNotificationActive = false;
  bool get isDailyNotificationActive => _isDailyNotificationActive;

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void _getDailyNotificationPreference() async {
    _isDailyNotificationActive =
        await preferenceHelper.isDailyNotificationActive;
    notifyListeners();
  }

  void enableDailyNotif(bool value) {
    preferenceHelper.setDailyNotification(value);
    _getDailyNotificationPreference();
  }

  void _getTheme() async {
    _isDarkTheme = await preferenceHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferenceHelper.setDarkTheme(value);
    _getTheme();
  }
}
