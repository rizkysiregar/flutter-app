import 'package:flutter/material.dart';
import 'package:restaurantapp/common/result_state.dart';
import 'package:restaurantapp/data/model/utils.dart';
import 'package:restaurantapp/data/network/api_service.dart';

class DetailProvider extends ChangeNotifier {
  RestaurantSearch restaurants;
  final ApiService apiService;

  DetailProvider({
    required this.restaurants,
    required this.apiService,
  }) {
    _fetchDetailRestaurant();
  }

  late DetailRestaurantResponse _detailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  DetailRestaurantResponse get detailResult => _detailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantDetail(restaurants.id);
      if (restaurant.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Errorr --> $e';
    }
  }
}
