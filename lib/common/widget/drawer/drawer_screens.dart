import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_note_taker/pages/archive/archive.dart';
import 'package:flutter_note_taker/pages/note/note.dart';
import '../../../pages/create_new_lable/create_new_lable.dart';
import '../../../pages/dekked/dekkd.dart';
import '../../../pages/delete/delete.dart';
import '../../../pages/help_feedback/help_feedback.dart';
import '../../../pages/reminder/reminder.dart';
import '../../../pages/setting/setting.dart';

changeScreen(EnumDrawerItems selectedDrawerItem) {
  switch (selectedDrawerItem) {
    case EnumDrawerItems.notes:
      return NoteScreen(); // Display the Notes screen

    case EnumDrawerItems.archive:
      return ArchiveScreen(); // Display the Reminders screen
    case EnumDrawerItems.reminder:
      return ReminderScreen(); // Display the Reminders screen

    case EnumDrawerItems.dekkd:
      return DekkdScreen(); // Display the Reminders screen

    case EnumDrawerItems.createNewLable:
      return CreateNewLableScreen(); // Display the Reminders screen

    case EnumDrawerItems.delete:
      return DeleteScreen(); // Display the Reminders screen

    case EnumDrawerItems.setting:
      return SettingScreen(); // Display the Reminders screen

    case EnumDrawerItems.help:
      return HelpFeedbackScreen(); // Display the Reminders screen
  }
}
