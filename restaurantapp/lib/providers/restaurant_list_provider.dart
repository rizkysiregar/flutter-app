import 'package:flutter/material.dart';
import 'package:restaurantapp/common/result_state.dart';
import 'package:restaurantapp/data/model/list_restaurant.dart';
import 'package:restaurantapp/data/network/api_service.dart';

class RestaurantListProvider extends ChangeNotifier {
  Restaurant restaurant;
  final ApiService apiService;

  RestaurantListProvider(
      {required this.restaurant, required this.apiService}) {}

  late RestaurantListResponse _restaurantListResponse;
  late ResultState _state;
  String _message = '';
  String get message => _message;

  Future<dynamic> fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Ooopss... Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantListResponse = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Erorr: $e';
    }
  }
}
