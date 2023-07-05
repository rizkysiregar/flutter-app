import 'package:flutter/material.dart';
import 'package:restaurantapp/data/model/detail_restaurant.dart';

class FoodsWidget extends StatelessWidget {
  final RestaurantDetail restaurant;

  const FoodsWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 100,
            width: 100,
            child: Stack(
              children: [
                Image.asset('images/foods.png'),
                Positioned(
                  bottom: 10,
                  child: Text(
                    restaurant.menus.foods[index].name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: restaurant.menus.foods.length,
      ),
    );
  }
}
