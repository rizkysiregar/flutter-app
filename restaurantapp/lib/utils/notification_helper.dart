import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurantapp/common/navigation.dart';
import 'package:restaurantapp/data/model/detail_restaurant.dart';
import 'package:restaurantapp/data/model/search_restaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  Random random = new Random();

  NotificationHelper.internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper.internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        print('Notification payload:' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      SearchRestaurantResponse restaurant) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "Restaurant Notification";

    var androidPlatfromChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var IOSPlatfromChannelSpecifics = const DarwinNotificationDetails();
    var platfromChannelSpecifics = NotificationDetails(
        android: androidPlatfromChannelSpecifics,
        iOS: IOSPlatfromChannelSpecifics);

    /// content notification
    var titleNotification = "<b>Restaurant Notification!!!</b>";
    var titleRestaurant = restaurant
        .restaurants[random.nextInt(restaurant.restaurants.length)].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platfromChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  void configuraionSelectionNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = SearchRestaurantResponse.fromJson(jsonDecode(payload));
      var restaurant = data.restaurants[0];
      Navigation.intentWithData(route, restaurant);
    });
  }
}
