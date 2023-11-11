import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note_taker/common/utils/provider/drawer_provider.dart';
import 'package:flutter_note_taker/common/utils/theme/is_dark_theme.dart';
import 'package:flutter_note_taker/common/utils/theme/theme_data.dart';
import 'package:flutter_note_taker/common/utils/theme/top_bottom_bar_theme.dart';
import 'package:flutter_note_taker/common/widget/drawer/custom_drawer.dart';
import 'package:flutter_note_taker/common/widget/widget.dart';
import 'package:flutter_note_taker/pages/note/notifire/note_notifire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/widget/drawer/drawer_screens.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static GlobalKey<ScaffoldState> drawerkey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    topBottomBarThemeChange(isDarkMode: isDarkMode);

    final appBarContentP = ref.read(appBarContentProvider.notifier);
    final selectionP = ref.read(selectionProvider.notifier);
    return WillPopScope(
      onWillPop: () async {
        if (appBarContentP.checkBool()) {
          clearSelection_appBarContent(selectionP, appBarContentP, isDarkMode);
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: drawerkey,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, _) {
              final selectedDrawerItem = ref.watch(selectedDrawerItemProvider);

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),

                /// Customize the animation curve when transitioning in
                switchInCurve: Curves.easeInOut,

                /// Customize the animation curve when transitioning out
                switchOutCurve: Curves.easeInOut,

                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: changeScreen(selectedDrawerItem),
              );
            },
          ),
        ),
        drawer: CustomDrawer(isDarkMode: isDarkMode),
      ),
    );
  }
}
