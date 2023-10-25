import 'dart:developer';
import 'package:flutter_note_taker/common/APIs/apis.dart';
import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_note_taker/common/utils/helper/helper.dart';
import 'package:flutter_note_taker/pages/add_note/notifire/add_note_notifire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNoteController {
  AddNoteController();

  static Future<void> handleNotes(WidgetRef ref) async {
    final note = ref.read(addNoteProvider);

    final bool hasNoteID = note.noteID.isNotEmpty;

    final String title = note.title.trim();
    final String content = note.content.trim();
    final String noteID = note.noteID;
    final bool isArchived = note.isArchived;
    final String image = note.bgImage;
    final bool isBGColorSet = note.isBGColorSet;
    try {
      if ((title.isNotEmpty || content.isNotEmpty) && hasNoteID == false) {
        print('add');
        //messages sending time(also used as id)
        final getTime = DateTime.now().millisecondsSinceEpoch.toString();

        ref.read(addNoteProvider.notifier).addNoteID(getTime);

        await APIs.addNote(tital: title, content: content, getTime: getTime);
        return;
      } else if ((title.isNotEmpty || content.isNotEmpty) &&
          hasNoteID == true) {
        await APIs.updateNote(
          noteID: noteID,
          title: title,
          content: content,
          bgImage: image,
          isBGColorSet: isBGColorSet,
          isArchived: isArchived,
        );
        return;
      }
    } catch (e) {
      Helper.showToastMessage(e.toString());
      log(e.toString());
    }
  }

  static Future<void> handleArchive(
      {required List<NoteModel> noteModel, required WidgetRef ref}) async {
    try {
      log(noteModel.map((e) => e.isArchived).toString());
      await APIs.updateArchiveNoteList(noteModel: noteModel);
    } catch (e) {
      Helper.showToastMessage(e.toString());
      log(e.toString());
    }
  }

  // static handleBGImage({required WidgetRef ref}) {
  //   final note = ref.read(addNoteProvider);
  //
  //   try {
  //     if (note.noteID.isNotEmpty) {
  //       APIs.updateNoteBGImage(noteID: note.noteID, bgImage: note.bgImage!);
  //     }
  //   } catch (e) {
  //     Helper.showToastMessage(e.toString());
  //     log(e.toString());
  //   }
  // }
}
