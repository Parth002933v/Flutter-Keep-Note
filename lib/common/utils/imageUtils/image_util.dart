import 'package:flutter/material.dart';

class DarkThemeImageBG {
  static const AssetImage bg1 =
      AssetImage("assets/background/darkThemeBG/bg1.png");
  static const AssetImage bg2 =
      AssetImage("assets/background/darkThemeBG/bg2.png");
  static const AssetImage bg3 =
      AssetImage("assets/background/darkThemeBG/bg3.png");
  static const AssetImage bg4 =
      AssetImage("assets/background/darkThemeBG/bg4.png");
  static const AssetImage bg5 =
      AssetImage("assets/background/darkThemeBG/bg5.png");
  static const AssetImage bg6 =
      AssetImage("assets/background/darkThemeBG/bg6.png");
  static const AssetImage bg7 =
      AssetImage("assets/background/darkThemeBG/bg7.png");
  static const AssetImage bg8 =
      AssetImage("assets/background/darkThemeBG/bg8.png");
  static const AssetImage bg9 =
      AssetImage("assets/background/darkThemeBG/bg9.png");
}

class LightThemeImageBG {
  static const AssetImage bg1 =
      AssetImage("assets/background/lightThemeBG/bg1.png");
  static const AssetImage bg2 =
      AssetImage("assets/background/lightThemeBG/bg2.png");
  static const AssetImage bg3 =
      AssetImage("assets/background/lightThemeBG/bg3.png");
  static const AssetImage bg4 =
      AssetImage("assets/background/lightThemeBG/bg4.png");
  static const AssetImage bg5 =
      AssetImage("assets/background/lightThemeBG/bg5.png");
  static const AssetImage bg6 =
      AssetImage("assets/background/lightThemeBG/bg6.png");
  static const AssetImage bg7 =
      AssetImage("assets/background/lightThemeBG/bg7.png");
  static const AssetImage bg8 =
      AssetImage("assets/background/lightThemeBG/bg8.png");
  static const AssetImage bg9 =
      AssetImage("assets/background/lightThemeBG/bg9.png");
}

void precacheLightThemeImages(BuildContext context) {
  print('Light');

  precacheImage(LightThemeImageBG.bg1, context);
  precacheImage(LightThemeImageBG.bg2, context);
  precacheImage(LightThemeImageBG.bg3, context);
  precacheImage(LightThemeImageBG.bg4, context);
  precacheImage(LightThemeImageBG.bg5, context);
  precacheImage(LightThemeImageBG.bg6, context);
  precacheImage(LightThemeImageBG.bg7, context);
  precacheImage(LightThemeImageBG.bg8, context);
  precacheImage(LightThemeImageBG.bg9, context);
}

precacheDarkThemeImages(BuildContext context) {
  print("dark");
  precacheImage(DarkThemeImageBG.bg2, context);
  precacheImage(DarkThemeImageBG.bg3, context);
  precacheImage(DarkThemeImageBG.bg4, context);
  precacheImage(DarkThemeImageBG.bg5, context);
  precacheImage(DarkThemeImageBG.bg6, context);
  precacheImage(DarkThemeImageBG.bg7, context);
  precacheImage(DarkThemeImageBG.bg8, context);
  precacheImage(DarkThemeImageBG.bg9, context);
}

class DarkThemeImageBGColor {
  static const Color bg1 = Color(0xff573a4e);
  static const Color bg2 = Color(0xff392c62);
  static const Color bg3 = Color(0xff103258);
  static const Color bg4 = Color(0xff382c50);
  static const Color bg5 = Color(0xff424459);
  static const Color bg6 = Color(0xff374b6e);
  static const Color bg7 = Color(0xff3a5d63);
  static const Color bg8 = Color(0xff511c22);
  static const Color bg9 = Color(0xff383838);
}

class LightThemeImageBGColor {
  static const Color bg1 = Color(0xfff9f1ee);
  static const Color bg2 = Color(0xffffe497);
  static const Color bg3 = Color(0xffbcdff2);
  static const Color bg4 = Color(0xffff756b);
  static const Color bg5 = Color(0xffffe1b3);
  static const Color bg6 = Color(0xfff8f3e0);
  static const Color bg7 = Color(0xffffe8e0);
  static const Color bg8 = Color(0xffffcdb2);
  static const Color bg9 = Color(0xffbad6ec);
}
