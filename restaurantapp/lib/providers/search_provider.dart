import 'package:flutter/material.dart';
import 'package:restaurantapp/common/result_state.dart';
import 'package:restaurantapp/data/model/search_restaurant.dart';
import 'package:restaurantapp/data/network/api_service.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late String query;

  SearchRestaurantProvider({
    required this.apiService,
    required this.query,
  }) {
    fetchResultData(query);
  }

  late SearchRestaurantResponse _searchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  SearchRestaurantResponse get result => _searchResult;
  ResultState get state => _state;

  Future<dynamic> fetchResultData(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantSearch(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
