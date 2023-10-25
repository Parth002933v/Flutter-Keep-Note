// class NoteModel {
//   NoteModel({
//     this.noteID = "",
//     this.title = "",
//     this.content = "",
//     this.createdAt = "",
//     this.updatedAt = "",
//   });
//   late final String noteID;
//   late final String title;
//   late final String content;
//   late final String createdAt;
//   late final String updatedAt;
//
//   NoteModel.fromJson(Map<String, dynamic> json) {
//     noteID = json['noteID'];
//     createdAt = json['createdAt'];
//     title = json['title'];
//     content = json['content'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//
//     data['noteID'] = noteID;
//     data['createdAt'] = createdAt;
//     data['title'] = title;
//     data['content'] = content;
//     data['updatedAt'] = updatedAt;
//     return data;
//   }
//
//   NoteModel copyWith({
//     String? noteID,
//     String? title,
//     String? content,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return NoteModel(
//       noteID: noteID ?? this.noteID,
//       title: title ?? this.title,
//       content: content ?? this.content,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';

class NoteModel {
  NoteModel({
    this.noteID = "",
    this.title = "",
    this.content = "",
    this.isArchived = false,
    this.bgImage = 'none',
    this.isBGColorSet = false,
    this.updatedAt,
    this.createdAt,
  });
  late final String noteID;
  late final String title;
  late final String content;
  late final bool isArchived;
  late final String bgImage;
  late final bool isBGColorSet;
  late final Timestamp? createdAt;
  late final Timestamp? updatedAt;

  NoteModel.fromJson(Map<String, dynamic> json) {
    noteID = json['noteID'];
    title = json['title'];
    content = json['content'];
    isArchived = json['isArchived'];
    bgImage = json['bgImage'];
    isBGColorSet = json['isBGColorSet'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['noteID'] = noteID;
    data['createdAt'] = FieldValue.serverTimestamp();
    data['title'] = title;
    data['isArchived'] = isArchived;
    data['content'] = content;
    data['bgImage'] = bgImage;
    data['isBGColorSet'] = isBGColorSet;
    data['updatedAt'] = FieldValue.serverTimestamp();
    return data;
  }

  NoteModel copyWith({
    String? noteID,
    String? title,
    String? content,
    bool? isArchived,
    String? bgImage,
    bool? isBGColorSet,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return NoteModel(
      noteID: noteID ?? this.noteID,
      title: title ?? this.title,
      content: content ?? this.content,
      isArchived: isArchived ?? this.isArchived,
      bgImage: bgImage ?? this.bgImage,
      isBGColorSet: isBGColorSet ?? this.isBGColorSet,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
