import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/result_state.dart';
import 'package:restaurantapp/data/model/search_restaurant.dart';

import 'package:restaurantapp/data/network/api_service.dart';
import 'package:restaurantapp/providers/detail_restaurant_provider.dart';
import 'package:restaurantapp/widgets/detail_widget.dart';

class DetailPage extends StatelessWidget {
  static const routeName = "/detail";
  RestaurantSearch restaurants;

  DetailPage({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailProvider(
          apiService: ApiService(Client()), restaurants: restaurants),
      child: Consumer<DetailProvider>(
        builder: (context, DetailProvider data, child) {
          if (data.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (data.state == ResultState.hasData) {
            var restaurant = data.detailResult;
            return Scaffold(
              body: DetailWidget(
                  restaurantDetail: restaurant.restaurant,
                  restaurantSearch: restaurants),
            );
          } else if (data.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(data.message),
              ),
            );
          } else if (data.state == ResultState.error) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.network_wifi_sharp),
                    Text('Sorry, no internet connection...'),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }
}
