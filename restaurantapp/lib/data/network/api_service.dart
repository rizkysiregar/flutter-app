import 'dart:convert';
import 'package:restaurantapp/data/model/detail_restaurant.dart';
import 'package:restaurantapp/data/model/list_restaurant.dart';
import 'package:http/http.dart' show Client;
import 'package:restaurantapp/data/model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  final Client client;
  ApiService(this.client);

  Future<RestaurantListResponse> restaurantList() async {
    final response = await client.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load list restaurant from API');
    }
  }

  Future<DetailRestaurantResponse> restaurantDetail(String id) async {
    final response = await client.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load detail data of restaurant');
    }
  }

  Future<SearchRestaurantResponse> restaurantSearch(String query) async {
    final response = await client.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data search page');
    }
  }
}
