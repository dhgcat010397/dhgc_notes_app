import 'package:dhgc_notes_app/src/features/home/data/datasources/local/note_local_datasource.dart';
import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';

class NoteLocalDatasourceImpl implements NoteLocalDatasource {
  NoteLocalDatasourceImpl();

  @override
  Future<List<NoteEntity>> fetchNotesList() {
    // TODO: implement fetchNotesList
    throw UnimplementedError();
  }

  @override
  Future<NoteEntity?> getNoteDetail(int noteId) {
    // TODO: implement getNoteDetail
    throw UnimplementedError();
  }

  @override
  Future<List<NoteEntity>> filterNoteByTitle(String query) {
    // TODO: implement filterNoteByTitle
    throw UnimplementedError();
  }

  @override
  Future<int> addNote(NoteEntity note) {
    // TODO: implement addNote
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteNote(int noteId) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<bool> updateNote(NoteEntity note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
