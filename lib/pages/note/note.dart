import 'package:flutter/material.dart';
import 'package:flutter_note_taker/common/APIs/apis.dart';
import 'package:flutter_note_taker/common/utils/theme/is_dark_theme.dart';
import 'package:flutter_note_taker/common/utils/theme/top_bottom_bar_theme.dart';
import 'package:flutter_note_taker/common/widget/widget.dart';
import 'package:flutter_note_taker/pages/note/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteScreen extends ConsumerWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Scrollbar(
          trackVisibility: true,
          thickness: 4,
          interactive: true,
          child: ListView(
            padding: EdgeInsets.only(bottom: 40.h),
            children: [
              // search
              AppBarContent(
                isDarkMode: isDarkMode,
                defaultAppBar:
                    defaultSearchBar(ref: ref, isDarkMode: isDarkMode),
              ),

              AllNotes(isDarkMode: isDarkMode),
            ],
          ),
        ),
        customContainor(context, isDarkMode),
        floatingButton(context, isDarkMode),
      ],
    );
  }
}
