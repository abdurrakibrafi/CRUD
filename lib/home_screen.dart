import 'package:crud/item_add_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenToDo extends StatefulWidget {
  const HomeScreenToDo({Key? key}) : super(key: key);

  @override
  State<HomeScreenToDo> createState() => _HomeScreenToDoState();
}

class _HomeScreenToDoState extends State<HomeScreenToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 100,
        title: Text(
          "CRUD APP",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
        actions: [
          Icon(
            Icons.search,
            size: 32,
            color: Colors.white,
          )
        ],
      ),
      body: AddItemScreen(),
    );
  }
}
