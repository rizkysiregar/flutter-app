import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/navigation.dart';
import 'package:restaurantapp/data/db/database.helper.dart';
import 'package:restaurantapp/data/model/search_restaurant.dart';
import 'package:restaurantapp/data/network/api_service.dart';
import 'package:restaurantapp/data/preference/preference_helper.dart';
import 'package:restaurantapp/providers/db/database_provider.dart';
import 'package:restaurantapp/providers/notification/scheduling_provider.dart';
import 'package:restaurantapp/providers/search_provider.dart';
import 'package:restaurantapp/providers/settings/preference_providers.dart';
import 'package:restaurantapp/ui/detail_page.dart';
import 'package:restaurantapp/ui/favorite_page.dart';
import 'package:restaurantapp/ui/search_page.dart';
import 'package:restaurantapp/ui/setting_page.dart';
import 'package:restaurantapp/utils/background_service.dart';
import 'package:restaurantapp/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SearchRestaurantProvider(
                apiService: ApiService(Client()), query: SearchPage.query),
          ),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
          ChangeNotifierProvider(
            create: (_) => PreferenceProviders(
                preferenceHelper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            )),
          ),
          ChangeNotifierProvider(
            create: (_) => SchedulingProvider(),
            child: const SettingsPage(),
          ),
        ],
        child: Consumer<PreferenceProviders>(
          builder: (context, provider, child) {
            return MaterialApp(
              theme: provider.themeData,
              navigatorKey: navigatorKey,
              initialRoute: SearchPage.routeName,
              routes: {
                SearchPage.routeName: (context) => const SearchPage(),
                DetailPage.routeName: (context) => DetailPage(
                      restaurants: ModalRoute.of(context)?.settings.arguments
                          as RestaurantSearch,
                    ),
                SettingsPage.routeName: (context) => const SettingsPage(),
                FavoritePage.routeName: (context) => const FavoritePage(),
              },
            );
          },
        ));
  }
}
