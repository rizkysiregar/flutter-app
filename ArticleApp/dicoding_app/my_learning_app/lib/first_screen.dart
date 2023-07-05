import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigatiion & Routing"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/secondScreen');
                },
                child: const Text('Go to second Screen')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/secondScreenWithData',
                      arguments: 'Hello from first Screen');
                },
                child: const Text('Navigation with Data')),
            ElevatedButton(
                onPressed: () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  final result =
                      await Navigator.pushNamed(context, '/returnDataScreen');
                  SnackBar snackBar = SnackBar(content: Text('$result'));
                  scaffoldMessenger.showSnackBar(snackBar);
                },
                child: const Text('Return data from another screen')),
            ElevatedButton(
                onPressed: () {}, child: const Text('Replace Screen'))
          ],
        ),
      ),
    );
  }
}
