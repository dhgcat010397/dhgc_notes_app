import 'package:equatable/equatable.dart';

import 'package:dhgc_notes_app/src/core/utils/mappers/model_convertable.dart';
import 'package:dhgc_notes_app/src/features/home/data/models/note_model.dart';

class NoteEntity extends Equatable
    with ModelConvertible<NoteEntity, NoteModel> {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime modifiedAt;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.modifiedAt,
  });

  @override
  List<Object?> get props => [id, title, content, createdAt, modifiedAt];

  @override
  NoteModel toModel() {
    return NoteModel(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      modifiedAt: modifiedAt,
    );
  }
}
