import 'package:flutter/material.dart';
import 'package:state_app/done_module_list.dart';
import 'package:state_app/module_list.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({super.key});

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memulai pemprograman dengan dart'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoneModuleList(
                            doneModulelist: doneModuleList,
                          )),
                );
              },
              icon: const Icon(Icons.done)),
        ],
      ),
      body: ModuleList(
        doneModuleList: doneModuleList,
      ),
    );
  }
}
