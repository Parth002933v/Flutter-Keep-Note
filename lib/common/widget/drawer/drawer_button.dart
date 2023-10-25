import 'package:flutter/material.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_note_taker/common/utils/provider/drawer_provider.dart';
import 'package:flutter_note_taker/common/utils/theme/is_dark_theme.dart';
import 'package:flutter_note_taker/common/utils/theme/theme_data.dart';
import 'package:flutter_note_taker/pages/note/notifire/note_notifire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawerButton extends ConsumerWidget {
  const CustomDrawerButton({
    super.key,
    required this.icon,
    required this.label,
    required this.enum_,
  });

  final Icon icon;

  final String label;
  // take enum value of drawer
  final EnumDrawerItems enum_;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDrawerProvider = ref.watch(selectedDrawerItemProvider);

    final isDarkMode = ThemeGetter.isDarkTheme(context);

    final selectedDrawerItemP = ref.read(selectedDrawerItemProvider.notifier);
    final appBarContentP = ref.read(appBarContentProvider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: TextButton.icon(
        onPressed: () {
          selectedDrawerItemP.state = enum_;

          appBarContentP.clearState(isDarkMode: isDarkMode);
          Navigator.of(context).pop();
        },
        style: ButtonStyle(
          // add some padding on button's content
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
          ),

          // Icon and Text Color (dark color)
          foregroundColor: MaterialStatePropertyAll(
            selectedDrawerProvider == enum_
                ? isDarkMode
                    ? DarkThemeData.drawerTextColor
                    : LightThemeData.drawerTextColor
                : isDarkMode
                    ? DarkThemeData.searchBarDrawerColor1
                    : const Color(0xff0b1d27),
          ),

          // position of button content
          alignment: Alignment.centerLeft,

          backgroundColor: MaterialStatePropertyAll(
            selectedDrawerProvider == enum_
                ? isDarkMode
                    ? DarkThemeData.drawerButton
                    : LightThemeData.drawerButton
                : Colors.transparent,
          ),
        ),
        label: Row(
          children: [
            SizedBox(width: 5.w),
            Text(label),
          ],
        ),
        icon: icon,
      ),
    );
  }
}
