import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note_taker/common/utils/theme/theme_data.dart';

void topBottomBarThemeChange({
  required bool isDarkMode,
  bool isAddStatusBarColor = false,
  bool bottom = true,
}) {
  bottom == false
      ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge)
      : null;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: isAddStatusBarColor
            ? isDarkMode
                ? DarkThemeData.floatingButtonColor
                : LightThemeData.floatingButtonColor
            : Colors.transparent,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: bottom == true
            ? isDarkMode
                ? DarkThemeData.searchBarColor
                : LightThemeData.searchBarColor
            : Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent,

        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark),
  );
}
