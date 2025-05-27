import 'package:equatable/equatable.dart';

import 'package:dhgc_notes_app/src/features/home/data/datasources/mappers/entity_convertable.dart';
import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';

class NotesListModel extends Equatable {
  final List<NoteModel> notes;
  final int total;

  const NotesListModel({required this.notes, required this.total});

  @override
  List<Object?> get props => [notes, total];

  factory NotesListModel.fromJson(Map<String, dynamic> json) {
    return NotesListModel(
      notes:
          (json['list_notes'] as List<dynamic>)
              .map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list_notes': notes.map((e) => e.toJson()).toList(),
      'total': total,
    };
  }
}

class NoteModel extends Equatable
    with EntityConvertible<NoteModel, NoteEntity> {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime modifiedAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.modifiedAt,
  });

  @override
  List<Object?> get props => [id, title, content, createdAt, modifiedAt];

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      modifiedAt: DateTime.parse(json['modified_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'modified_at': modifiedAt.toIso8601String(),
    };
  }

  @override
  NoteEntity toEntity() {
    return NoteEntity(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      modifiedAt: modifiedAt,
    );
  }
}
