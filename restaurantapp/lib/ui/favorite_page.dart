import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/result_state.dart';
import 'package:restaurantapp/providers/db/database_provider.dart';
import 'package:restaurantapp/widgets/card.dart';

class FavoritePage extends StatelessWidget {
  static const String routeName = '/favorite';
  static const String title = 'Your Favorite Restaurant';

  const FavoritePage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return ListCard(restaurant: provider.favorite[index]);
            },
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text('there is error -->${provider.message}'),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text('something went wrong'),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: _buildList(),
    );
  }
}
