import 'package:flutter/material.dart';
import 'package:restaurantapp/common/result_state.dart';
import 'package:restaurantapp/data/db/database.helper.dart';
import 'package:restaurantapp/data/model/search_restaurant.dart';

class DatabaseProvider extends ChangeNotifier {
  DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantSearch> _favorite = [];
  List<RestaurantSearch> get favorite => _favorite;

  void _getFavorite() async {
    _state = ResultState.loading;
    _favorite = await databaseHelper.getFavoriteRestaurants();
    notifyListeners();
    if (_favorite.length > 0) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Kamu Belum Punya Restaurant Favorite!';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantSearch restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error in addFavorite: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error in romove: $e';
      notifyListeners();
    }
  }
}
