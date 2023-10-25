import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNoteNotifier extends StateNotifier<NoteModel> {
  AddNoteNotifier() : super(NoteModel());

  void onTitalChange(String tital) {
    state = state.copyWith(title: tital);
  }

  void onContentChange(String content) {
    state = state.copyWith(content: content);
  }

  void addNoteID(String noteID) {
    if (state.noteID.isEmpty) {
      state = state.copyWith(noteID: noteID);
    }
  }

  void onArchive() {
    if (state.isArchived) {
      state = state.copyWith(isArchived: false);
      print("is archived : ${state.isArchived}");
    } else {
      state = state.copyWith(isArchived: true);
      print("is archived : ${state.isArchived}");
    }
  }

  void onBGChange(String bgImageEnum) {
    print("onBGChange :  $bgImageEnum");

    state = state.copyWith(bgImage: bgImageEnum, isBGColorSet: false);
  }

  void onBGColorChange(String bgImageEnum) {
    if (bgImageEnum == 'none') {
      state = state.copyWith(bgImage: bgImageEnum, isBGColorSet: false);
    }
    state = state.copyWith(bgImage: bgImageEnum, isBGColorSet: true);
  }

  void setNoteModelData(NoteModel noteModel) {
    print(noteModel.noteID);

    state = state.copyWith(
      noteID: noteModel.noteID,
      title: noteModel.title,
      content: noteModel.content,
      createdAt: noteModel.createdAt,
      updatedAt: noteModel.updatedAt,
      bgImage: noteModel.bgImage,
      isBGColorSet: noteModel.isBGColorSet,
      isArchived: noteModel.isArchived,
    );
  }

  void clearState() {
    state = NoteModel(); // Assuming AddNoteState is your state class
    print(
        "provider is cleared : and value is : ID:${state.noteID.isNotEmpty}, titale:${state.title}, content:${state.content}, create:${state.createdAt}, update:${state.updatedAt} ");
  }
}

///----------------Provider-----------------------------------------------------
final addNoteProvider =
    StateNotifierProvider<AddNoteNotifier, NoteModel>((ref) {
  return AddNoteNotifier();
});
