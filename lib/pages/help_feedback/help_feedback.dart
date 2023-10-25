import 'package:flutter/material.dart';
import 'package:flutter_note_taker/HomeScreen.dart';

class HelpFeedbackScreen extends StatelessWidget {
  const HelpFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () {



              HomeScreen.drawerkey.currentState!.openDrawer();
            }, icon: Icon(Icons.menu)),
          ],
        ),

        Center(
          child: Text("Help & feedback Screen"),
        ),
      ],
    );
  }
}
