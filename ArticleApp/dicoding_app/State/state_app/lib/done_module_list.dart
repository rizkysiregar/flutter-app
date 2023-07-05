import 'package:flutter/material.dart';

class DoneModuleList extends StatelessWidget {
  final List<String> doneModulelist;

  const DoneModuleList({super.key, required this.doneModulelist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Done module list'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(doneModulelist[index]),
            );
          },
          itemCount: doneModulelist.length,
        ));
  }
}
