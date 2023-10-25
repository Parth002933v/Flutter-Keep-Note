import 'package:flutter/material.dart';

import '../../HomeScreen.dart';

class DekkdScreen extends StatelessWidget {
  const DekkdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  HomeScreen.drawerkey.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu)),
          ],
        ),
        Center(
          child: Text("Dekkd Screer"),
        ),
      ],
    );
  }
}
