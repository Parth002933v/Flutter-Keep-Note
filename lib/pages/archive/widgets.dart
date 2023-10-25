import 'package:flutter/material.dart';
import 'package:flutter_note_taker/HomeScreen.dart';
import 'package:flutter_note_taker/pages/note/notifire/note_notifire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/widget/text_widget.dart';

Widget defaultArchiveAppBar({
  required WidgetRef ref,
  required bool isDarkMode,
}) {
  return Row(
    children: [
      IconButton(
          onPressed: () {
            HomeScreen.drawerkey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu)),
      text18Normal(text: "Archive", isDarkMode: isDarkMode),
      const Spacer(),
      IconButton(
        tooltip: "Search",
        onPressed: () {
          ref.read(appBarContentProvider.notifier).onSearch();
        },
        icon: const Icon(Icons.search),
      ),
      IconButton(onPressed: () {}, icon: const Icon(Icons.grid_view_outlined))
    ],
  );
}
