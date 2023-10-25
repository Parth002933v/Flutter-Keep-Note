import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_note_taker/common/utils/helper/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class APIs {
  /// For accessing cloud Firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // static String getTime = DateTime.now().millisecondsSinceEpoch.toString();

  /// create the reference of that path location where we store the data
  static CollectionReference<Map<String, dynamic>> ref = firestore
      .collection("users")
      .doc("swIKzsoSQUl36XkXNJcV")
      .collection("notes");

  // // take all notes form firebase
  // static Query<Map<String, dynamic>> takeAllNotes = firestore
  //     .collection("users")
  //     .doc("swIKzsoSQUl36XkXNJcV") // my user id
  //     .collection("notes")
  //     .orderBy('noteID', descending: true);
  //
  // // convert the notes into snapshot
  // static Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream() {
  //   return // notes
  //       takeAllNotes.snapshots();
  // }

  // /// for getting single record from firebase
  // static Future<String> getNoteIDFormFirebase(String noteID) async {
  //   final snapshot = await ref.where("noteID", isEqualTo: noteID).get();
  //
  //   final data = snapshot.docs.map((e) => NoteModel.fromSnapshot(e)).single;
  //
  //   return data.noteID;
  // }

  /// adding note
  static Future<void> addNote({
    required String tital,
    required String content,
    required String getTime,
  }) async {
    // save the model formate data in noteData to send it in firestore
    final NoteModel noteData = NoteModel(
      noteID: getTime,
      title: tital,
      content: content,
    );

    // send the data in that reference with create the doc(time) file name.
    // also convert that data into json formate
    await ref.doc(getTime).set(noteData.toJson()).catchError((e) {
      Helper.showToastMessage(e);
    });
  }

  /// Update the frestore data
  static Future<void> updateNote({
    required String noteID,
    required String title,
    required String content,
    required bool isArchived,
    required String bgImage,
    required bool isBGColorSet,
  }) async {
    await ref.doc(noteID).update({
      'title': title,
      'content': content,
      'isArchived': isArchived,
      'bgImage': bgImage,
      'isBGColorSet': isBGColorSet,
      'updatedAt': FieldValue.serverTimestamp()
    }).catchError((e) => Helper.showToastMessage(e));
  }

  static updateNoteBGImage(
      {required String noteID, required String bgImage}) async {
    await ref.doc(noteID).update({
      'bgImage': bgImage,
    }).catchError((e) => Helper.showToastMessage(e));
  }

  static Future<void> updateArchiveNoteList({
    required List<NoteModel> noteModel,
  }) async {
    for (int i = 0; i < noteModel.length; i++) {
      log(noteModel[i].isArchived.toString());
      await ref
          .doc(noteModel[i].noteID)
          .update({'isArchived': noteModel[i].isArchived}).catchError(
        (error) {
          return Helper.showToastMessage(error);
        },
      );
    }
  }

  /// to delete the note
  static Future<void> delete(List<NoteModel> noteID) async {
    //
    for (int i = 0; i < noteID.length; i++) {
      await ref.doc(noteID[i].noteID).delete().catchError(
        (error) {
          return Helper.showToastMessage(error);
        },
      );
    }
  }

  /// get notes from database
  static StreamProvider<QuerySnapshot<Map<String, dynamic>>>
      notesStreamProvider = StreamProvider(
    (ref) {
      final stream = firestore
          .collection("users")
          .doc("swIKzsoSQUl36XkXNJcV")
          .collection("notes")
          .where('isArchived', isEqualTo: false) // Add this condition
          .orderBy('noteID', descending: true)
          .snapshots();

      return stream;
    },
  );

  /// get notes from database
  static StreamProvider<QuerySnapshot<Map<String, dynamic>>>
      archivednotesStreamProvider = StreamProvider(
    (ref) {
      final stream = firestore
          .collection("users")
          .doc("swIKzsoSQUl36XkXNJcV")
          .collection("notes")
          .where('isArchived', isEqualTo: true) // Add this condition
          .orderBy('noteID', descending: true)
          .snapshots();

      return stream;
    },
  );
}
