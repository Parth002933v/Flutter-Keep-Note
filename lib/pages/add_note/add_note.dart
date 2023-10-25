// decoration: const BoxDecoration(
// color: Colors.transparent,
// image: DecorationImage(
// image: AssetImage('assets/background/bg2.png'),
// fit: BoxFit.cover,
// ),
// ),

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_note_taker/common/utils/helper/myDateUtils.dart';
import 'package:flutter_note_taker/common/utils/imageUtils/image_util.dart';
import 'package:flutter_note_taker/common/utils/theme/is_dark_theme.dart';
import 'package:flutter_note_taker/common/utils/theme/theme_data.dart';
import 'package:flutter_note_taker/common/utils/theme/top_bottom_bar_theme.dart';
import 'package:flutter_note_taker/pages/add_note/add_note_controller.dart';
import 'package:flutter_note_taker/pages/add_note/notifire/add_note_notifire.dart';
import 'package:flutter_note_taker/pages/add_note/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNoteScreen extends ConsumerStatefulWidget {
  const AddNoteScreen({super.key});

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends ConsumerState<AddNoteScreen> {
  late String? title;
  late String? content;
  late Timestamp? updateAt;
  bool isUpdate = false;

  // late String bgImage;

  @override
  void initState() {
    super.initState();
    print('initState');
    title = ref.read(addNoteProvider).title;
    content = ref.read(addNoteProvider).content;
    updateAt = ref.read(addNoteProvider).updatedAt;
    // bgImage = ref.read(addNoteProvider).bgImage;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ThemeGetter.isDarkTheme(context);
    topBottomBarThemeChange(isDarkMode: isDarkMode, bottom: false);

    final addNoteValue = ref.watch(addNoteProvider);
    final addNoteP = ref.read(addNoteProvider.notifier);

    getRouteArgument(context);

    final getBGImageEnumFromImageP = BGImageEnum.values
        .singleWhere((enumValue) => enumValue.name == addNoteValue.bgImage);

    return WillPopScope(
      onWillPop: () async {
        addNoteP.clearState();
        topBottomBarThemeChange(isDarkMode: isDarkMode);

        return true;
      },
      child: Container(
        decoration: BoxDecoration(
          image: (addNoteValue.bgImage != 'none') && (addNoteValue.isBGColorSet)
              ? null
              : addNoteValue.bgImage != 'none'
                  ? DecorationImage(
                      image: buildAssetImage(
                        enumValue: getBGImageEnumFromImageP,
                        isDarkMode: isDarkMode,
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
        ),
        height: double.infinity,
        child: Scaffold(
          appBar:
              addNoteAppBar(isDarkMode: isDarkMode, context: context, ref: ref),
          backgroundColor:
              (addNoteValue.bgImage != 'none') && (addNoteValue.isBGColorSet)
                  ? bottomSheetColor(
                      enumValue: getBGImageEnumFromImageP,
                      isDarkMode: isDarkMode)
                  : (addNoteValue.bgImage != 'none')
                      ? Colors.transparent
                      : isDarkMode
                          ? DarkThemeData.primaryBackgroundColor
                          : Colors.white,
          body: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                // note
                Positioned(
                  top: 5.h,
                  bottom: 40.h,
                  left: 0,
                  right: 0,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      TextFormField(
                        initialValue: title,
                        onChanged: (title) {
                          addNoteP.onTitalChange(title);
                          AddNoteController.handleNotes(ref);
                        },
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.robotoSlab(fontSize: 25),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle:
                              TextStyle(fontSize: 25, color: Colors.grey),
                        ),
                      ),

                      // note
                      TextFormField(
                        initialValue: content,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        onChanged: (content) {
                          addNoteP.onContentChange(content);
                          AddNoteController.handleNotes(ref);
                        },
                        maxLines: null,
                        autofocus: !isUpdate,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: 'Type Something Here',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),

                // bottom bar
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_box_outlined)),
                        IconButton(
                            onPressed: () {
                              // showBackgroundSelector(
                              //   isDarkMode: isDarkMode,
                              //   context: context,
                              //   enumValue: getBGImageEnumFromImageP,
                              // );

                              showBackgroundSelector(
                                  context: context, isDarkMode: isDarkMode);
                            },
                            icon: const Icon(Icons.color_lens_outlined)),
                        IconButton(
                            tooltip: "Show formatting controls",
                            onPressed: () {},
                            icon: const Icon(Icons.format_color_text)),
                        Expanded(
                          child: Text(
                            'Edited ${updateAt == null ? MyDateUtils.formatTimestamp(DateTime.now()) : MyDateUtils.formatTimestamp(updateAt!.toDate())}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12.spMin,
                              overflow: TextOverflow.ellipsis,
                              color: isDarkMode
                                  ? DarkThemeData.noteTextColor
                                  : Colors.black54,
                              fontWeight: isDarkMode
                                  ? FontWeight.w400
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert_rounded),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getRouteArgument(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // Check if args is not null, and then access the parameters
    if (args != null) {
      isUpdate = args['isUpdate'];
    }
  }
}
