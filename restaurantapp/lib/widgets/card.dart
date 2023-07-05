import 'package:flutter/material.dart';
import 'package:restaurantapp/common/navigation.dart';
import 'package:restaurantapp/data/model/search_restaurant.dart';
import 'package:restaurantapp/ui/detail_page.dart';

class ListCard extends StatelessWidget {
  RestaurantSearch restaurant;
  static const _baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/large/';
  ListCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.lightBlue,
          height: 100,
          width: 100,
          child: Image.network(
            "${_baseUrlImage}${restaurant.pictureId}",
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_city,
                size: 16,
              ),
              Text(restaurant.city, style: const TextStyle(fontSize: 12)),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.rate_review, size: 16),
              Text(restaurant.rating.toString())
            ],
          )
        ],
      ),
      onTap: () => Navigation.intentWithData(DetailPage.routeName, restaurant),
    );
  }
}
