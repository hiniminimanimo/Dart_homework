import 'package:flutter/material.dart';
import 'package:tasks/main/add_to_do_button.dart';
import 'package:tasks/main/empty_taskcard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("희은's Tasks"),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ColoredBox(
        color: Colors.grey.shade400,
        child: Column(children: [EmptyTaskcard()]),
      ),
      floatingActionButton: AddButton(),
    );
  }
}
