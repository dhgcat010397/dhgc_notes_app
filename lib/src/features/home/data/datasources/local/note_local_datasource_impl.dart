import 'package:dhgc_notes_app/src/core/helpers/database_helper.dart';
import 'package:dhgc_notes_app/src/features/home/data/datasources/local/note_local_datasource.dart';
import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';

class NoteLocalDatasourceImpl implements NoteLocalDatasource {
  NoteLocalDatasourceImpl();

  @override
  Future<List<NoteEntity>> fetchNotesList() {
    final notesList = DatabaseHelper.instance.getNotes();

    return notesList.then(
      (notes) => notes.map((note) => note.toEntity()).toList(),
    );
  }

  @override
  Future<NoteEntity?> getNoteDetail(int noteId) {
    final note = DatabaseHelper.instance.getNoteById(noteId);

    return note.then((noteModel) {
      if (noteModel != null) {
        return noteModel.toEntity();
      } else {
        return null;
      }
    });
  }

  @override
  Future<List<NoteEntity>> filterNoteByTitle(String query) {
    final notesList = DatabaseHelper.instance.filterNotesByTitle(query);

    return notesList.then(
      (notes) => notes.map((note) => note.toEntity()).toList(),
    );
  }

  @override
  Future<int> addNote(NoteEntity note) async {
    final noteModel = note.toModel();
    final noteId = await DatabaseHelper.instance.createNote(noteModel);

    return noteId;
  }

  @override
  Future<bool> deleteNote(int noteId) async {
    final count = await DatabaseHelper.instance.deleteNote(noteId);

    return count > 0;
  }

  @override
  Future<bool> updateNote(NoteEntity note) async {
    final noteModel = note.toModel();
    final count = await DatabaseHelper.instance.updateNote(noteModel);

    return count > 0;
  }
}
