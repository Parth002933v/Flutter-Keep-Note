import 'package:flutter/material.dart';
import 'package:flutter_note_taker/common/APIs/apis.dart';
import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/theme/is_dark_theme.dart';
import 'package:flutter_note_taker/common/widget/widget.dart';
import 'package:flutter_note_taker/pages/add_note/notifire/add_note_notifire.dart';
import 'package:flutter_note_taker/pages/archive/widgets.dart';
import 'package:flutter_note_taker/pages/note/notifire/note_notifire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchedNote = ref.watch(APIs.archivednotesStreamProvider);
    final searchText = ref.watch(onSearchKeyWordProvider);
    final isDarkMode = ThemeGetter.isDarkTheme(context);

    return SafeArea(
      child: Scrollbar(
        trackVisibility: true,
        thickness: 4,
        interactive: true,
        child: ListView(
          children: [
            AppBarContent(
              isDarkMode: isDarkMode,
              defaultAppBar:
                  defaultArchiveAppBar(ref: ref, isDarkMode: isDarkMode),
            ),
            // Padding for grid view of notes
            Padding(
              //padding
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
              child: fetchedNote.when(
                data: (data) {
                  // pass data value in our list of notes in form of NoteModel
                  List<NoteModel> notes = data.docs
                      .map((e) => NoteModel.fromJson(e.data()))
                      .where((note) =>
                          note.title.toLowerCase().contains(searchText) ||
                          note.content.toLowerCase().contains(searchText))
                      .toList();

                  return notes.isEmpty
                      ? const Center(
                          child: Text("No Note Found"),
                        )
                      : Consumer(
                          builder: (context, reff, child) {
                            reff.watch(selectionProvider);
                            final appBarContentP =
                                ref.read(appBarContentProvider.notifier);
                            final addNoteP =
                                reff.read(addNoteProvider.notifier);
                            final selection = reff.read(selectionProvider);
                            final selectionP =
                                reff.read(selectionProvider.notifier);
                            return MasonryGridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              shrinkWrap: true,

                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),

                              itemCount: notes.length,

                              // Build note preview
                              itemBuilder: (context, index) {
                                print(
                                    'build itembulder and lenth is : ${notes.length}');
                                final noteValue = notes[index];

                                final isSelectedNote =
                                    selection.contains(noteValue);

                                return noteContanor(
                                  appBarContentP: appBarContentP,
                                  addNoteP: addNoteP,
                                  noteValue: noteValue,
                                  context: context,
                                  selection: selection,
                                  selectionP: selectionP,
                                  isSelectedNote: isSelectedNote,
                                  isDarkMode: isDarkMode,
                                );
                              },
                            );
                          },
                        );
                },
                error: (error, stack) =>
                    Center(child: SelectableText('Error: $error')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
    // drawer: CustomDrawer(),
  }
}
