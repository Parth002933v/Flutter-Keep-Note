import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note_taker/common/APIs/apis.dart';
import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/Routes/routes.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_note_taker/common/utils/helper/helper.dart';
import 'package:flutter_note_taker/common/utils/imageUtils/image_util.dart';
import 'package:flutter_note_taker/common/utils/theme/theme_data.dart';
import 'package:flutter_note_taker/common/utils/theme/top_bottom_bar_theme.dart';
import 'package:flutter_note_taker/common/widget/text_widget.dart';
import 'package:flutter_note_taker/pages/add_note/add_note_controller.dart';
import 'package:flutter_note_taker/pages/add_note/notifire/add_note_notifire.dart';
import 'package:flutter_note_taker/pages/add_note/widgets.dart';
import 'package:flutter_note_taker/pages/note/notifire/note_notifire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarContent extends ConsumerWidget {
  const AppBarContent({
    super.key,
    required this.isDarkMode,
    required this.defaultAppBar,
  });

  final bool isDarkMode;
  final Widget defaultAppBar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarContent = ref.watch(appBarContentProvider);

    if (appBarContent.isSelected) {
      return selectionWidget(ref: ref, isDarkMode: isDarkMode);
    } else if (appBarContent.isSearch) {
      return onSearchWidget(ref: ref, isDarkMode: isDarkMode);
    } else {
      return defaultAppBar;
    }
  }
}

///-----------------------------------------------------------------------------
Widget noteContanor({
  required AppBarContentNotifier appBarContentP,
  required AddNoteNotifier addNoteP,
  required NoteModel noteValue,
  required BuildContext context,
  required List<NoteModel> selection,
  required SelectionNotifier selectionP,
  required bool isSelectedNote,
  required bool isDarkMode,
}) {
  final getBGImageEnumFromImageP =
      getBGImageEnumFromImageProvider(imageP: noteValue.bgImage);
  return InkWell(
    borderRadius: BorderRadius.circular(10.r),
    onTap: () {
      if (appBarContentP.isSelected() == false) {
        addNoteP.setNoteModelData(noteValue);
        Navigator.of(context)
            .pushNamed(Routes.addNote, arguments: {"isUpdate": true});
      } else {
        selectionP.select(noteValue);
      }
    },
    onLongPress: () {
      appBarContentP.onSelection();
      selectionP.select(noteValue);
    },
    child: Container(
      padding: EdgeInsets.all(15.spMin),
      decoration: BoxDecoration(
        image: noteValue.bgImage == 'none'
            ? null
            : noteValue.isBGColorSet
                ? null
                : DecorationImage(
                    image: buildAssetImage(
                        enumValue: getBGImageEnumFromImageP,
                        isDarkMode: isDarkMode),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.centerRight,
                    repeat: ImageRepeat.repeat,
                  ),
        border: Border.all(
          width: isSelectedNote ? 3 : 1,
          color:
              isSelectedNote ? Colors.lightBlueAccent : const Color(0xff7f8082),
        ),
        borderRadius: BorderRadius.circular(10.r),
        color: (noteValue.bgImage != 'none') && (noteValue.isBGColorSet)
            ? bottomSheetColor(
                enumValue: getBGImageEnumFromImageP, isDarkMode: isDarkMode)
            : (noteValue.bgImage != 'none')
                ? Colors.transparent
                : isDarkMode
                    ? DarkThemeData.primaryBackgroundColor
                    : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // note tital
          noteValue.title.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(
                    bottom: 5.h,
                  ),
                  child: titleText(noteValue),
                ),

          // note content
          contentText(noteValue: noteValue, isDarkMode: isDarkMode),
        ],
      ),
    ),
  );
}

///-----------------------------------------------------------------------------
Widget selectionWidget({required WidgetRef ref, required bool isDarkMode}) {
  topBottomBarThemeChange(
    isDarkMode: isDarkMode,
    isAddStatusBarColor: ref.read(appBarContentProvider.notifier).checkBool(),
  );

  final appBarContentP = ref.read(appBarContentProvider.notifier);
  final selectionP = ref.read(selectionProvider.notifier);
  final selection = ref.watch(selectionProvider);
  final onSeachKeyWordP = ref.read(onSearchKeyWordProvider.notifier);
  return Container(
    // BackgroundColor change according to themeMode
    color: isDarkMode
        ? DarkThemeData.floatingButtonColor
        : LightThemeData.floatingButtonColor,

    height: 50.h,
    // use riverpod, selection
    child: Row(
      children: [
        Row(
          children: [
            // close Icon
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: IconButton(
                  tooltip: "Close",
                  onPressed: () {
                    clearSelection_appBarContent(
                        selectionP, appBarContentP, isDarkMode);
                  },
                  icon: const Icon(Icons.close)),
            ),

            // Number of selected Notes
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                selection.length.toString(),
                // selection.length.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),

        // add some sapace
        const Spacer(),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Pin
            IconButton(
                tooltip: "Pin",
                onPressed: () {},
                icon: const Icon(Icons.push_pin_outlined)),

            // Select All
            IconButton(
                tooltip: "Select All",
                onPressed: () {},
                icon: const Icon(Icons.select_all)),

            // see more
            PopupMenuButton(
              icon: Icon(Icons.more_vert_rounded,
                  color: isDarkMode ? Colors.white70 : Colors.black54),
              color: isDarkMode
                  ? DarkThemeData.floatingButtonColor
                  : LightThemeData.floatingButtonColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () async {
                    final List<NoteModel> noteList =
                        selectionP.toggleIsArchive();

                    await AddNoteController.handleArchive(
                      noteModel: noteList,
                      ref: ref,
                    );

                    clearSelection_appBarContent(
                        selectionP, appBarContentP, isDarkMode);
                  },
                  value: 1,
                  child: const Text('Archive'),
                ),

                // to delete selected Note
                PopupMenuItem(
                  value: 2,
                  child: const Text('Delete'),
                  onTap: () async {
                    // take notes to delete
                    final wantToDelete = ref.read(selectionProvider);

                    // delete form firebase
                    await APIs.delete(wantToDelete);

                    // clear the state provider and remove selection
                    clearSelection_appBarContent(
                        selectionP, appBarContentP, isDarkMode);
                    onSeachKeyWordP.update((state) => '');

                    // show the dialoge msg
                    if (context.mounted) {
                      Helper.showScaffoldMessage(
                          'Your Note Has been deleted', context);
                    }
                  },
                ),

                // show if only one note is selected
                if (ref.read(selectionProvider).length == 1)
                  PopupMenuItem(
                    onTap: () {
                      copyText(ref: ref, isDarkMode: isDarkMode);
                      onSeachKeyWordP.update((state) => '');
                      appBarContentP.clearState(isDarkMode: isDarkMode);
                    },
                    value: 3,
                    child: const Text('copy text'),
                  ),
                const PopupMenuItem(value: 4, child: Text('Send')),
                const PopupMenuItem(
                    value: 5, child: Text('Copy to Google Docs')),
              ],
            ),
          ],
        )
      ],
    ),
  );
}

///-----------------------------------------------------------------------------
// ignore: non_constant_identifier_names
void clearSelection_appBarContent(SelectionNotifier selectionP,
    AppBarContentNotifier appBarContentP, bool isDarkMode) {
  selectionP.clearTheState();
  appBarContentP.clearState(isDarkMode: isDarkMode);
}

///-----------------------------------------------------------------------------
Widget onSearchWidget({required WidgetRef ref, required bool isDarkMode}) {
  topBottomBarThemeChange(
    isDarkMode: isDarkMode,
    isAddStatusBarColor: ref.read(appBarContentProvider.notifier).checkBool(),
  );

  final appBarContentP = ref.read(appBarContentProvider.notifier);
  return Container(
    height: 50.h,
    decoration: BoxDecoration(
      color: isDarkMode
          ? DarkThemeData.floatingButtonColor
          : LightThemeData.floatingButtonColor,
    ),
    child: Row(
      children: [
        // back button
        IconButton(
            tooltip: "back",
            onPressed: () {
              topBottomBarThemeChange(isDarkMode: isDarkMode);
              appBarContentP.clearState(isDarkMode: isDarkMode);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        Expanded(
          child: TextFormField(
            onChanged: (value) {
              ref
                  .read(onSearchKeyWordProvider.notifier)
                  .update((state) => value);
            },
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Search your notes....",
                hintStyle: TextStyle(color: DarkThemeData.searchBarHintColor2),
                border: InputBorder.none),
          ),
        ),
      ],
    ),
  );
}

///-----------------------------------------------------------------------------
// to copy the state txt
void copyText({
  required WidgetRef ref,
  required bool isDarkMode,
}) {
  final noteToCopy = ref.read(selectionProvider);
  final selectionP = ref.read(selectionProvider.notifier);

  final appBarContentP = ref.read(appBarContentProvider.notifier);
  final onSeachKeyWordP = ref.read(onSearchKeyWordProvider.notifier);

  // to Cpoy The selected Text
  if (noteToCopy[0].title.isNotEmpty && noteToCopy[0].content.isNotEmpty) {
    Clipboard.setData(
      ClipboardData(
        text:
            'Title : ${noteToCopy[0].title.toString()} \nContent : ${noteToCopy[0].content.toString()}',
      ),
    );
  } else {
    Clipboard.setData(
      ClipboardData(
        text: '${noteToCopy[0].title}${noteToCopy[0].content}'.trim(),
      ),
    );
  }

  onSeachKeyWordP.update((state) => '');
  clearSelection_appBarContent(selectionP, appBarContentP, isDarkMode);
}
