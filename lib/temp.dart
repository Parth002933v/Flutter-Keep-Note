  // import 'package:flutter/material.dart';
  // import 'package:flutter/services.dart';
  // import 'package:flutter_note_taker/common/utils/enums/enums.dart';
  // import 'package:flutter_note_taker/common/utils/imageUtils/image_util.dart';
  // import 'package:flutter_note_taker/common/utils/theme/is_dark_theme.dart';
  //
  // import 'common/utils/theme/theme_data.dart';
  //
  // class temp extends StatelessWidget {
  //   const temp({super.key});
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     SystemChrome.setSystemUIOverlayStyle(
  //       SystemUiOverlayStyle(
  //         statusBarColor: Colors.transparent,
  //         systemNavigationBarColor: Colors.transparent,
  //         // systemNavigationBarContrastEnforced: true,
  //       ),
  //     );
  //
  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //
  //     String bg = 'bg5';
  //     print('the value is');
  //     print(BGImageEnum.values.singleWhere((element) => element.name == bg));
  //     final get = BGImageEnum.values.singleWhere((element) => element.name == bg);
  //     final isDarkMode = ThemeGetter.isDarkTheme(context);
  //
  //     return Container(
  //       height: double.infinity,
  //       decoration: BoxDecoration(
  //         // color: Colors.transparent,
  //         image: bg != 'none'
  //             ? DecorationImage(
  //                 image: buildAssetImage(get: get), fit: BoxFit.cover)
  //             : null,
  //       ),
  //       child: Scaffold(
  //         extendBody: true,
  //         backgroundColor: bg == 'none'
  //             ? isDarkMode
  //                 ? DarkThemeData.primaryBackgroundColor
  //                 : Colors.white
  //             : Colors.transparent,
  //         body: Center(child: Text('data')),
  //       ),
  //     );
  //   }
  //
  //   AssetImage buildAssetImage({required BGImageEnum get}) {
  //     switch (get) {
  //       case BGImageEnum.bg1:
  //         return AssetImage(DarkThemeImageBG.bg1);
  //       case BGImageEnum.none:
  //         return AssetImage('');
  //
  //       case BGImageEnum.bg3:
  //         return AssetImage(DarkThemeImageBG.bg3);
  //       // TODO: Handle this case.
  //       case BGImageEnum.bg4:
  //         return AssetImage(DarkThemeImageBG.bg4);
  //       // TODO: Handle this case.
  //       case BGImageEnum.bg5:
  //         return AssetImage(DarkThemeImageBG.bg5);
  //       // TODO: Handle this case.
  //       case BGImageEnum.bg6:
  //         return AssetImage(DarkThemeImageBG.bg6);
  //       // TODO: Handle this case.
  //       case BGImageEnum.bg7:
  //         return AssetImage(DarkThemeImageBG.bg7);
  //       // TODO: Handle this case.
  //       case BGImageEnum.bg8:
  //         return AssetImage(DarkThemeImageBG.bg8);
  //       // TODO: Handle this case.
  //       case BGImageEnum.bg9:
  //         return AssetImage(DarkThemeImageBG.bg9);
  //       // TODO: Handle this case.
  //       case BGImageEnum.bg2:
  //         return AssetImage(DarkThemeImageBG.bg2);
  //
  //       // TODO: Handle this case.
  //     }
  //   }
  // }
