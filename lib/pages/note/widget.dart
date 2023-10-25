import 'package:flutter/material.dart';
import 'package:flutter_note_taker/HomeScreen.dart';
import 'package:flutter_note_taker/common/APIs/apis.dart';
import 'package:flutter_note_taker/common/model/note_model.dart';
import 'package:flutter_note_taker/common/utils/Heros/heros.dart';
import 'package:flutter_note_taker/common/utils/Routes/routes.dart';
import 'package:flutter_note_taker/common/widget/text_widget.dart';
import 'package:flutter_note_taker/common/widget/widget.dart';
import 'package:flutter_note_taker/pages/add_note/notifire/add_note_notifire.dart';
import 'package:flutter_note_taker/pages/note/notifire/note_notifire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../common/utils/theme/theme_data.dart';

///-----------------------------------------------------------------------------
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.9166667);
    path_0.lineTo(size.width * 0.6847500, size.height * 0.9166833);
    path_0.lineTo(size.width * 0.7003833, size.height * 0.9254417);
    path_0.lineTo(size.width * 0.7156333, size.height * 0.9517500);
    path_0.lineTo(size.width * 0.7332667, size.height * 0.9583333);
    path_0.lineTo(size.width * 0.8504333, size.height * 0.9583333);
    path_0.lineTo(size.width * 0.8682333, size.height * 0.9512833);
    path_0.lineTo(size.width * 0.8834667, size.height * 0.9246083);
    path_0.lineTo(size.width * 0.9016833, size.height * 0.9166167);
    path_0.lineTo(size.width, size.height * 0.9166667);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.9166667);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

///-----------------------------------------------------------------------------
class AllNotes extends ConsumerWidget {
  const AllNotes({
    super.key,
    required this.isDarkMode,
    // required this.fetchedNote,
  });

  final bool isDarkMode;
  // final AsyncValue<QuerySnapshot<Map<String, dynamic>>> fetchedNote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLandscape = MediaQuery.of(context).size.width > 450;

    final fetchedNote = ref.watch(APIs.notesStreamProvider);

    final searchText = ref.watch(onSearchKeyWordProvider);

    print('fuul build');
    return Column(
      children: [
        // "All" text
        Container(
          margin: EdgeInsets.only(
            left: 20.w,
            top: 10.h,
            bottom: 10.h,
          ),
          alignment: Alignment.centerLeft,
          child: const Text('All'),
        ),

        // Padding for grid view of notes
        Padding(
          //padding
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            bottom: 10.h,
          ),
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
                        // reff.watch(selectionProvider);
                        final appBarContentP =
                            ref.read(appBarContentProvider.notifier);
                        final addNoteP = reff.read(addNoteProvider.notifier);
                        final selection = reff.watch(selectionProvider);
                        final selectionP =
                            reff.read(selectionProvider.notifier);
                        return MasonryGridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          shrinkWrap: true,

                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isLandscape ? 3 : 2,

                            // crossAxisCount: 1,
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
                              isDarkMode: isDarkMode,
                              appBarContentP: appBarContentP,
                              addNoteP: addNoteP,
                              noteValue: noteValue,
                              context: context,
                              selection: selection,
                              selectionP: selectionP,
                              isSelectedNote: isSelectedNote,
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
    );
  }
}

///-----------------------------------------------------------------------------
Widget defaultSearchBar({required WidgetRef ref, required bool isDarkMode}) {
  final appBarContentP = ref.read(appBarContentProvider.notifier);
  return Container(
    width: double.infinity,
    height: 45.h,
    padding: EdgeInsets.symmetric(horizontal: 9.w),
    margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),

    // margin: EdgeInsets.symmetric(horizontal: 15.w),
    decoration: BoxDecoration(
      color: isDarkMode
          ? DarkThemeData.searchBarColor
          : LightThemeData.searchBarColor,
      borderRadius: BorderRadius.circular(30.r),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Drawer Icon
        Padding(
          padding: EdgeInsets.only(right: 3.w),
          child: IconButton(
              tooltip: "Open Navigation Drawer",
              color: isDarkMode ? DarkThemeData.searchBarDrawerColor1 : null,
              iconSize: 25,
              onPressed: () {
                HomeScreen.drawerkey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu)),
        ),

        // Search Hint text
        TextButton(
          style: const ButtonStyle(
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
          ),
          onPressed: () {
            appBarContentP.onSearch();
          },
          child: Text(
            'Search your notes',
            style: TextStyle(
              fontSize: 15.spMin,
              fontWeight: FontWeight.w400,
              color: isDarkMode
                  ? DarkThemeData.searchBarHintColor2
                  : LightThemeData.searchBarHintColor2,
            ),
          ),
        ),

        const Spacer(),
        // Grid Icons
        Row(
          children: [
            IconButton(
                tooltip: "Change Grid View",
                onPressed: () {},
                icon: const Icon(Icons.grid_view_outlined)),

            // Profile Icon
            IconButton(
                tooltip: "Profile",
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined)),
          ],
        )
      ],
    ),
  );
}

///-----------------------------------------------------------------------------
Positioned customContainor(BuildContext context, bool isDarkMode) {
  return Positioned(
    bottom: 0,
    child: ClipPath(
      clipper: CurveClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 15.w),
        height: 500.h,
        width: MediaQuery.of(context).size.width,
        color: isDarkMode
            ? DarkThemeData.searchBarColor
            : LightThemeData.searchBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                tooltip: "New list",
                onPressed: () {},
                icon: const Icon(Icons.check_box_outlined)),
            IconButton(
                tooltip: "New drawing note",
                onPressed: () {},
                icon: const Icon(Icons.brush_outlined)),
            IconButton(
                tooltip: "New audio note",
                onPressed: () {},
                icon: const Icon(Icons.mic_none)),
            IconButton(
                tooltip: "New photo note",
                onPressed: () {},
                icon: const Icon(Icons.image_outlined))
          ],
        ),
      ),
    ),
  );
}

///addNoteButton-----------------------------------------------------------------------------
Positioned floatingButton(BuildContext context, bool isDarkMode) {
  return Positioned(
    bottom: 27.h,
    // left: 260.w,
    right: 50.w,
    child: Hero(
      tag: Heros.flotingAndBack,
      child: Consumer(
        builder: (context, ref, child) {
          ref.watch(appBarContentProvider);
          final isSelectedORSerch =
              ref.watch(appBarContentProvider.notifier).checkBool();
          return isSelectedORSerch
              ? const SizedBox()
              : FloatingActionButton(
                  foregroundColor: Colors.red,
                  heroTag: null,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.addNote),
                  splashColor: isDarkMode
                      ? DarkThemeData.searchBarColor
                      : LightThemeData.searchBarColordark,
                  backgroundColor: isDarkMode
                      ? DarkThemeData.searchBarColor
                      : LightThemeData.searchBarColor,
                  child: Image.asset(
                    "assets/icons/plusIcon.png",
                    width: 30.spMin,
                    fit: BoxFit.fitWidth,
                  ),
                );
        },
      ),
    ),
  );
}
