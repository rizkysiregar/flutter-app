import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/result_state.dart';
import 'package:restaurantapp/providers/search_provider.dart';
import 'package:restaurantapp/widgets/list_widget.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  static String query = '';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  bool isSearchActive = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, SearchRestaurantProvider data, child) {
        if (data.state == ResultState.loading) {
          /// show progress bar
          return Center(child: CircularProgressIndicator());
        } else if (data.state == ResultState.hasData) {
          return ListWidget(
              query: SearchPage.query,
              controller: controller,
              isSearchActive: isSearchActive,
              state: data);
        } else if (data.state == ResultState.noData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Dicoding Restaurant'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        SearchPage.query = '';
                        controller.text = '';
                        isSearchActive = true;
                        data.fetchResultData(SearchPage.query);
                      });
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.restaurant_menu_outlined,
                    size: 60,
                  ),
                  Text(
                    "Sorry, we couldn't find the restaurant or food\n you were looking for :(",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else if (data.state == ResultState.error) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.network_wifi),
                  Text('You have a problem with the internet connection :( )')
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
