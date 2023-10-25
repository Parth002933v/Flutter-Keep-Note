import 'package:flutter/material.dart';
import 'package:flutter_note_taker/HomeScreen.dart';

class CreateNewLableScreen extends StatelessWidget {
  const CreateNewLableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              HomeScreen.drawerkey.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu)),
        Text("Create New Lable Screer"),
      ],
    );
  }
}
