import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_taker/common/utils/Routes/routes.dart';
import 'package:flutter_note_taker/common/utils/helper/helper.dart';
import 'package:flutter_note_taker/firebase_options.dart';
import 'package:flutter_note_taker/HomeScreen.dart';
import 'package:flutter_note_taker/pages/add_note/add_note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/utils/imageUtils/image_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('material');

    // precacheDarkThemeImages(context);
    // precacheLightThemeImages(context);

    precacheImage(LightThemeImageBG.bg1, context);
    precacheImage(LightThemeImageBG.bg2, context);
    precacheImage(LightThemeImageBG.bg3, context);
    precacheImage(LightThemeImageBG.bg4, context);
    precacheImage(LightThemeImageBG.bg5, context);
    precacheImage(LightThemeImageBG.bg6, context);
    precacheImage(LightThemeImageBG.bg7, context);
    precacheImage(LightThemeImageBG.bg8, context);
    precacheImage(LightThemeImageBG.bg9, context);

    precacheImage(
      DarkThemeImageBG.bg1,
      context,
      onError: (exception, stackTrace) {
        Helper.showToastMessage(exception.toString());
      },
    );
    precacheImage(
      DarkThemeImageBG.bg2,
      context,
      onError: (exception, stackTrace) {
        Helper.showToastMessage(exception.toString());
      },
    );
    precacheImage(
      DarkThemeImageBG.bg3,
      context,
      onError: (exception, stackTrace) {
        Helper.showToastMessage(exception.toString());
      },
    );
    precacheImage(
      DarkThemeImageBG.bg4,
      context,
      onError: (exception, stackTrace) {
        Helper.showToastMessage(exception.toString());
      },
    );
    precacheImage(
      DarkThemeImageBG.bg5,
      context,
      onError: (exception, stackTrace) {
        Helper.showToastMessage(exception.toString());
      },
    );
    precacheImage(
      DarkThemeImageBG.bg6,
      context,
      onError: (exception, stackTrace) {
        Helper.showToastMessage(exception.toString());
      },
    );
    precacheImage(
      DarkThemeImageBG.bg7,
      context,
      onError: (exception, stackTrace) {
        Helper.showToastMessage(exception.toString());
      },
    );
    precacheImage(DarkThemeImageBG.bg8, context);
    precacheImage(DarkThemeImageBG.bg9, context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(useMaterial3: true),
        theme: ThemeData.light(useMaterial3: true),
        themeMode: ThemeMode.system,
        initialRoute: "/",
        routes: {
          Routes.home: (context) => const HomeScreen(),
          Routes.addNote: (context) => const AddNoteScreen(),
          // '/temp': (context) => temp(),
        },
      ),
    );
  }
}
