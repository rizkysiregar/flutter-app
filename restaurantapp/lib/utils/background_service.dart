import 'dart:isolate';
import 'dart:ui';
import 'package:http/http.dart';
import 'package:restaurantapp/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurantapp/data/network/api_service.dart';
import 'package:restaurantapp/main.dart';
import 'package:restaurantapp/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolatedName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolatedName,
    );
  }

  static Future<void> callback() async {
    print('Alarm Fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService(Client()).restaurantSearch('');
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolatedName);
    _uiSendPort?.send(null);
  }
}
