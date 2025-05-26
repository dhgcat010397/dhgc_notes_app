import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';

abstract class NoteLocalDatasource {
  /// Fetches the list of notes.
  Future<List<NoteEntity>> fetchNotesList();

  /// Fetches the details of a specific note by its ID.
  Future<NoteEntity?> getNoteDetail(int noteId);

  /// Filters notes by title.
  Future<List<NoteEntity>> filterNoteByTitle(String query);

  /// Adds a new note.
  Future<int> addNote(NoteEntity note);

  /// Updates an existing note.
  Future<bool> updateNote(NoteEntity note);

  /// Deletes a note by its ID.
  Future<bool> deleteNote(int noteId);
}
