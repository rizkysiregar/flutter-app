import 'package:flutter/material.dart';
import 'package:restaurantapp/providers/search_provider.dart';
import 'package:restaurantapp/ui/favorite_page.dart';
import 'package:restaurantapp/ui/setting_page.dart';
import 'package:restaurantapp/widgets/card.dart';

class ListWidget extends StatefulWidget {
  String query = '';
  final TextEditingController controller;
  bool isSearchActive = false;
  final SearchRestaurantProvider state;

  ListWidget(
      {Key? key,
      required this.query,
      required this.controller,
      required this.isSearchActive,
      required this.state});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// check app bar wit ternary operator
      appBar: widget.isSearchActive
          ? AppBar(
              title: const Text('Dicoding Restaurant'),
              actions: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      /// turn on and of search box
                      widget.isSearchActive = !widget.isSearchActive;
                    });
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 14),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SettingsPage.routeName);
                    },
                    icon: const Icon(Icons.settings),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            )
          : AppBar(
              title: Container(
                width: 292,
                height: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          setState(() {
                            if (widget.controller.text.isEmpty) {
                              widget.controller.text = '';
                            }
                            widget.query = widget.controller.text.toString();
                            widget.state.fetchResultData(widget.query);
                          });
                        },
                        controller: widget.controller,
                        cursorColor: Colors.black,
                        decoration:
                            const InputDecoration(hintText: 'Cari disini!'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.controller.text.isEmpty) {
                          widget.controller.text = '';
                        }
                        widget.query = widget.controller.text.toString();
                        widget.state.fetchResultData(widget.query);
                      },
                      child: const Icon(Icons.search),
                    )
                  ],
                ),
              ),
            ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var restaurant = widget.state.result.restaurants[index];
          return GestureDetector(
            onPanDown: (details) {
              setState(() {
                if (widget.query == '') {
                  widget.isSearchActive = true;
                }
              });
            },
            child: ListCard(restaurant: restaurant),
          );
        },
        itemCount: widget.state.result.restaurants.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, FavoritePage.routeName);
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
