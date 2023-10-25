import 'package:flutter/material.dart';
import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/Heros/heros.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_note_taker/common/utils/imageUtils/image_util.dart';
import 'package:flutter_note_taker/common/utils/theme/is_dark_theme.dart';
import 'package:flutter_note_taker/common/utils/theme/theme_data.dart';
import 'package:flutter_note_taker/common/utils/theme/top_bottom_bar_theme.dart';
import 'package:flutter_note_taker/pages/add_note/add_note_controller.dart';
import 'package:flutter_note_taker/pages/add_note/notifire/add_note_notifire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/main.dart';

AppBar addNoteAppBar({
  required bool isDarkMode,
  required BuildContext context,
  required WidgetRef ref,
}) {
  final addNoteP = ref.read(addNoteProvider.notifier);
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    flexibleSpace: SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Hero(
                tag: Heros.flotingAndBack,
                child: IconButton(
                  tooltip: "Navigate To Up",
                  color: isDarkMode ? Colors.white : Colors.black,
                  onPressed: () {
                    addNoteP.clearState();
                    print("clearTheState");
                    topBottomBarThemeChange(isDarkMode: isDarkMode);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    //color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    tooltip: "Pin",
                    onPressed: () {},
                    icon: const Icon(Icons.push_pin_outlined)),
                IconButton(
                    tooltip: "Reminder",
                    onPressed: () {},
                    icon: const Icon(Icons.alarm_add_rounded)),
                IconButton(
                    tooltip: "Archive",
                    onPressed: () async {
                      addNoteP.onArchive();

                      AddNoteController.handleNotes(ref)
                          .whenComplete(() => Navigator.of(context).pop());
                    },
                    icon: const Icon(Icons.archive_outlined)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

///-----------------------------------------------------------------------------

AssetImage buildAssetImage(
    {required BGImageEnum enumValue, required bool isDarkMode}) {
  switch (enumValue) {
    case BGImageEnum.bg1:
      return isDarkMode ? DarkThemeImageBG.bg1 : LightThemeImageBG.bg1;
    case BGImageEnum.none:
      return const AssetImage('');
    case BGImageEnum.bg3:
      return isDarkMode ? DarkThemeImageBG.bg3 : LightThemeImageBG.bg3;
    case BGImageEnum.bg4:
      return isDarkMode ? DarkThemeImageBG.bg4 : LightThemeImageBG.bg4;
    case BGImageEnum.bg5:
      return isDarkMode ? DarkThemeImageBG.bg5 : LightThemeImageBG.bg5;
    case BGImageEnum.bg6:
      return isDarkMode ? DarkThemeImageBG.bg6 : LightThemeImageBG.bg6;
    case BGImageEnum.bg7:
      return isDarkMode ? DarkThemeImageBG.bg7 : LightThemeImageBG.bg7;
    case BGImageEnum.bg8:
      return isDarkMode ? DarkThemeImageBG.bg8 : LightThemeImageBG.bg8;
    case BGImageEnum.bg9:
      return isDarkMode ? DarkThemeImageBG.bg9 : LightThemeImageBG.bg9;
    case BGImageEnum.bg2:
      return isDarkMode ? DarkThemeImageBG.bg2 : LightThemeImageBG.bg2;
  }
}

///-----------------------------------------------------------------------------
Color bottomSheetColor({
  required BGImageEnum enumValue,
  required bool isDarkMode,
  // bool isBGColorSelected = false,
}) {
  if ((enumValue.name != 'none')) {
    switch (enumValue) {
      case BGImageEnum.bg1:
        return isDarkMode
            ? DarkThemeImageBGColor.bg1
            : LightThemeImageBGColor.bg1;
      case BGImageEnum.none:
        return isDarkMode
            ? DarkThemeData.primaryBackgroundColor
            : LightThemeData.primaryBackgroundColor;
      case BGImageEnum.bg2:
        return isDarkMode
            ? DarkThemeImageBGColor.bg2
            : LightThemeImageBGColor.bg2;
      case BGImageEnum.bg3:
        return isDarkMode
            ? DarkThemeImageBGColor.bg3
            : LightThemeImageBGColor.bg3;
      case BGImageEnum.bg4:
        return isDarkMode
            ? DarkThemeImageBGColor.bg4
            : LightThemeImageBGColor.bg4;
      case BGImageEnum.bg5:
        return isDarkMode
            ? DarkThemeImageBGColor.bg5
            : LightThemeImageBGColor.bg5;
      case BGImageEnum.bg6:
        return isDarkMode
            ? DarkThemeImageBGColor.bg6
            : LightThemeImageBGColor.bg6;
      case BGImageEnum.bg7:
        return isDarkMode
            ? DarkThemeImageBGColor.bg7
            : LightThemeImageBGColor.bg7;
      case BGImageEnum.bg8:
        return isDarkMode
            ? DarkThemeImageBGColor.bg8
            : LightThemeImageBGColor.bg8;
      case BGImageEnum.bg9:
        return isDarkMode
            ? DarkThemeImageBGColor.bg9
            : LightThemeImageBGColor.bg9;
    }
  } else {
    return isDarkMode
        ? DarkThemeData.primaryBackgroundColor
        : LightThemeData.primaryBackgroundColor;
  }
  // switch (enumValue) {
  //   case BGImageEnum.bg1:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg1
  //         : LightThemeImageBGColor.bg1;
  //   case BGImageEnum.none:
  //     return isDarkMode
  //         ? DarkThemeData.primaryBackgroundColor
  //         : LightThemeData.primaryBackgroundColor;
  //   case BGImageEnum.bg2:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg2
  //         : LightThemeImageBGColor.bg2;
  //   case BGImageEnum.bg3:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg3
  //         : LightThemeImageBGColor.bg3;
  //   case BGImageEnum.bg4:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg4
  //         : LightThemeImageBGColor.bg4;
  //   case BGImageEnum.bg5:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg5
  //         : LightThemeImageBGColor.bg5;
  //   case BGImageEnum.bg6:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg6
  //         : LightThemeImageBGColor.bg6;
  //   case BGImageEnum.bg7:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg7
  //         : LightThemeImageBGColor.bg7;
  //   case BGImageEnum.bg8:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg8
  //         : LightThemeImageBGColor.bg8;
  //   case BGImageEnum.bg9:
  //     return isDarkMode
  //         ? DarkThemeImageBGColor.bg9
  //         : LightThemeImageBGColor.bg9;
  // }
}

void showBackgroundSelector({
  required BuildContext context,
  required bool isDarkMode,
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    context: context,
    builder: (context) {
      return const BottomSheetContent();
    },
  );
}

BGImageEnum getBGImageEnumFromImageProvider({required String imageP}) {
  return BGImageEnum.values
      .singleWhere((enumValue) => enumValue.name == imageP);
}

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    return Consumer(
      builder: (context, ref, child) {
        final addNoteProviderValue = ref.watch(addNoteProvider);

        final getBGImageEnumFromImageP = getBGImageEnumFromImageProvider(
            imageP: addNoteProviderValue.bgImage);

        return Container(
          color: bottomSheetColor(
            enumValue: getBGImageEnumFromImageP,
            isDarkMode: isDarkMode,
            // isBGColorSelected: true,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.h),
          height: 250.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Background Color'),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...BGImageEnum.values.map(
                      (bgImageEnumValue) => bgOptions(
                        isBGColorSelect: true,
                        bgEnum: bgImageEnumValue,
                        ref: ref,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ],
                ),
              ),
              const Text('Background'),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...BGImageEnum.values.map(
                      (bgImageEnumValue) => bgOptions(
                        bgEnum: bgImageEnumValue,
                        ref: ref,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

InkWell bgOptions({
  isBGColorSelect = false,
  required BGImageEnum bgEnum,
  required WidgetRef ref,
  required bool isDarkMode,
}) {
  final addNoteP = ref.read(addNoteProvider);
  final getBGEnumValue =
      getBGImageEnumFromImageProvider(imageP: addNoteP.bgImage);

  return InkWell(
    onTap: () {
      onChageBG(isBGColorSelect, bgEnum, ref);
    },
    customBorder: const CircleBorder(),
    // enableFeedback: true,
    child: isBGColorSelect
        ? bgColorSelectContainer(bgEnum, isDarkMode, addNoteP, getBGEnumValue)
        : bgImageSelectContainer(
            bgEnum, isDarkMode, isBGColorSelect, addNoteP, getBGEnumValue),
  );
}

Container bgImageSelectContainer(BGImageEnum bgEnum, bool isDarkMode,
    isBGColorSelect, NoteModel addNoteP, BGImageEnum getBGEnumValue) {
  return Container(
    height: 60,
    width: 60,
    margin: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: bottomSheetColor(
        enumValue: bgEnum,
        isDarkMode: isDarkMode,
      ),

      image: isBGColorSelect
          ? null
          : DecorationImage(
              image: buildAssetImage(
                enumValue: bgEnum,
                isDarkMode: isDarkMode,
              ),
              fit: BoxFit.cover,
            ),

      border: !addNoteP.isBGColorSet
          ? bgEnum != getBGEnumValue
              ? Border.all(width: 2, color: Colors.grey)
              : Border.all(width: 3, color: Colors.blue.shade700)
          : (bgEnum.name == 'none')
              ? Border.all(width: 3, color: Colors.blue.shade700)
              : Border.all(width: 2, color: Colors.grey),

      shape: BoxShape.circle,
      // color: Colors.transparent,
    ),
    child: bgEnum.name == 'none'
        ? const Icon(Icons.image_not_supported_outlined)
        : null,
  );
}

Container bgColorSelectContainer(BGImageEnum bgEnum, bool isDarkMode,
    NoteModel addNoteP, BGImageEnum getBGEnumValue) {
  return Container(
    height: 60,
    width: 60,
    margin: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: bottomSheetColor(
        enumValue: bgEnum,
        isDarkMode: isDarkMode,
      ),

      // image: isBGColorSelect
      //     ? null
      //     : DecorationImage(
      //         image: buildAssetImage(
      //           enumValue: bgImageEnum,
      //           isDarkMode: isDarkMode,
      //         ),
      //         fit: BoxFit.cover,
      //       ),

      // border: (imageEnumValue == bgImageEnum) && addNoteP.isBGColorSet
      //     ? Border.all(width: 2, color: Colors.blue.shade700)
      //     : (bgImageEnum.name == 'none') && (!addNoteP.isBGColorSet)
      //         ? Border.all(width: 2, color: Colors.blue.shade700)
      //         : Border.all(width: 1, color: Colors.grey),

      // border: bgEnum == getBGEnumValue
      //     ? Border.all(width: 3, color: Colors.blue.shade700)
      //     : Border.all(width: 1, color: Colors.grey),

      border: addNoteP.isBGColorSet
          ? bgEnum == getBGEnumValue
              ? Border.all(width: 3, color: Colors.blue.shade700)
              : Border.all(width: 2, color: Colors.grey)
          : (bgEnum.name != 'none')
              ? Border.all(width: 2, color: Colors.grey)
              : Border.all(width: 3, color: Colors.blue.shade700),

      shape: BoxShape.circle,
      // color: Colors.transparent,
    ),
    child: bgEnum.name == 'none'
        ? const Icon(Icons.format_color_reset_outlined)
        : null,
  );
}

Future<void> onChageBG(
  isBGColorSelect,
  BGImageEnum bgImageEnum,
  WidgetRef ref,
) async {
  final addNoteP = ref.read(addNoteProvider.notifier);

  isBGColorSelect
      ? addNoteP.onBGColorChange(bgImageEnum.name)
      : addNoteP.onBGChange(bgImageEnum.name);

  await AddNoteController.handleNotes(ref);


}

///-----------------------------------------------------------------------------
