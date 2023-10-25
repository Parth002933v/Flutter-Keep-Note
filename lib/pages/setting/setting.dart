import 'package:flutter/material.dart';
import 'package:flutter_note_taker/HomeScreen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  HomeScreen.drawerkey.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu)),
          ],
        ),
        Center(
          child: Text("Setting  Screer"),
        ),
      ],
    );
  }
}
