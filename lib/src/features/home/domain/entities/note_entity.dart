import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int id;
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
}
