import 'package:flutter/material.dart';
import 'package:restaurantapp/widgets/settings_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String pageTitle = 'Settings';
  static const String routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
    return SettingsWidget();
  }
}
