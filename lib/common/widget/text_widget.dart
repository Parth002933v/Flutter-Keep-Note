import 'package:flutter/material.dart';
import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/theme/theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget text14Normal({
  String text = "Enter The text",
  required bool isDarkMode,
}) =>
    Text(
      text,
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 14.spMin,
      ),
    );

Widget text18Normal({
  String text = "Enter The text",
  required bool isDarkMode,
}) =>
    Text(
      text,
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 18.spMin,
      ),
    );

Text titleText(NoteModel noteValue) {
  return Text(
    noteValue.title, // Access title from note
    maxLines: null,
    //overflow: TextOverflow.ellipsis,
    style: GoogleFonts.robotoSlab(
      fontSize: 16.spMin,
      fontWeight: FontWeight.w600,
    ),
  );
}

Text contentText({
  required NoteModel noteValue,
  required bool isDarkMode,
}) {
  return Text(
    noteValue.content, // Access content from note
    maxLines: 10,
    overflow: TextOverflow.ellipsis,
    softWrap: true,
    style: TextStyle(
      fontSize: 15.spMin,
      overflow: TextOverflow.ellipsis,
      color: isDarkMode
          ? DarkThemeData.noteTextColor
          : LightThemeData.noteTextColor,
      fontWeight: FontWeight.w400,
    ),
  );
}
