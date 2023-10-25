import 'dart:developer';
import 'dart:ffi';

import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/theme/top_bottom_bar_theme.dart';
import 'package:flutter_note_taker/common/widget/widget.dart';
import 'package:flutter_note_taker/pages/note/notifire/note_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarContentNotifier extends StateNotifier<AppBarContentModel> {
  AppBarContentNotifier() : super(AppBarContentModel());

  void onSelection() {
    state = state.copyWith(isSelected: true, isSearch: false);
  }

  void onSearch() {
    state = state.copyWith(isSearch: true, isSelected: false);
  }

  void clearState({required bool isDarkMode}) {
    state = AppBarContentModel();
    topBottomBarThemeChange(isDarkMode: isDarkMode);
  }

  bool checkBool() {
    if (state.isSelected || state.isSearch) {
      return true;
    } else {
      return false;
    }
  }

  bool isSelected() {
    if (state.isSelected) {
      return true;
    } else {
      return false;
    }
  }
}

final appBarContentProvider =
    StateNotifierProvider<AppBarContentNotifier, AppBarContentModel>((ref) {
  return AppBarContentNotifier();
});

///-----------------------------------------------------------------------------

class SelectionNotifier extends StateNotifier<List<NoteModel>> {
  SelectionNotifier() : super([]);

  // final SelectionNotifier selectionP = SelectionNotifier(this._appBarContentNotifier);
  // final AppBarContentNotifier appBarContentP = AppBarContentNotifier();

  void select(NoteModel note) {
    // if provider has data
    if (state.contains(note)) {
      // If it is favourite it will remove
      state =
          state.where((stateNote) => stateNote.noteID != note.noteID).toList();

      print("the lenth is ${state.length}");
      print(state.map((e) => e.noteID));
    } else {
      // if is is not favourite it will add it
      state = [...state, note];
      print("the lenth is ${state.length}");

      print(state.map((e) => e.noteID));
    }
  }

  List<NoteModel> toggleIsArchive() {
    state = state.map((note) {
      return NoteModel(
        noteID: note.noteID,
        title: note.title,
        content: note.content,
        isArchived: !note.isArchived,
        updatedAt: note.updatedAt,
        createdAt: note.createdAt,
      );
    }).toList();

    log(state.map((e) => e.noteID).toString());
    return state;
  }

  void clearTheState() {
    state = [];

    print("selectionProvide Cleared");
    print("the lenth is ${state.length}");
  }
}

StateNotifierProvider<SelectionNotifier, List<NoteModel>> selectionProvider =
    StateNotifierProvider<SelectionNotifier, List<NoteModel>>(
        (ref) => SelectionNotifier());

///-----------------------------------------------------------------------------
final onSearchKeyWordProvider = StateProvider<String>((ref) {
  return '';
});

///-----------------------------------------------------------------------------
