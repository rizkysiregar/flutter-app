import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/providers/notification/scheduling_provider.dart';
import 'package:restaurantapp/providers/settings/preference_providers.dart';
import 'package:restaurantapp/widgets/custom_dialog.dart';

class SettingsWidget extends StatelessWidget {
  SettingsWidget({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return Consumer<PreferenceProviders>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Scheduling Notification'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, child) {
                    return Switch.adaptive(
                      value: provider.isDailyNotificationActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledNotification(value);
                          provider.enableDailyNotif(value);
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _buildList(context),
    );
  }
}
