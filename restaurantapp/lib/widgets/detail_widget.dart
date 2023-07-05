import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurantapp/data/model/utils.dart';
import 'package:restaurantapp/providers/db/database_provider.dart';
import 'package:restaurantapp/widgets/drinks_widget.dart';
import 'package:restaurantapp/widgets/foods_widget.dart';

class DetailWidget extends StatelessWidget {
  static const _baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/large/';
  RestaurantDetail restaurantDetail;
  RestaurantSearch restaurantSearch;
  DetailWidget(
      {Key? key,
      required this.restaurantDetail,
      required this.restaurantSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isFavorite = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantDetail.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                    tag: restaurantDetail.pictureId,
                    child: Image.network(
                        "${_baseUrlImage}${restaurantDetail.pictureId}")),
                SizedBox(
                  child: Consumer<DatabaseProvider>(
                    builder: (context, provider, child) {
                      return FutureBuilder<bool>(
                        future: provider.isFavorited(restaurantSearch.id),
                        builder: (context, snapshot) {
                          var isFavorited = snapshot.data ?? false;
                          return Padding(
                            padding: EdgeInsets.all(4),
                            child: isFavorited
                                ? IconButton(
                                    iconSize: 45,
                                    color: Colors.red,
                                    onPressed: () {
                                      /// remove from favorite
                                      provider
                                          .removeFavorite(restaurantSearch.id);
                                    },
                                    icon: const Icon(Icons.favorite))
                                : IconButton(
                                    onPressed: () {
                                      provider.addFavorite(restaurantSearch);
                                    },
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                    iconSize: 45,
                                  ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantDetail.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(restaurantDetail.city),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.reviews_rounded),
                      SizedBox(width: 10),
                      Text(restaurantDetail.rating.toString())
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  restaurantDetail.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Our Foods',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            FoodsWidget(restaurant: restaurantDetail),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Our Drinks',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            DrinksWidget(restaurant: restaurantDetail),
          ],
        ),
      ),
    );
  }
}
