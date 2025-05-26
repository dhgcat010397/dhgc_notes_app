import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';

abstract class NoteRepo {
  /// Fetches the list of notes.
  /// Returns a [List<NoteEntity>] containing all notes.
  /// Throws an exception if the fetch fails.
  Future<List<NoteEntity>> fetchNotesList();

  /// Fetches the details of a specific note by its ID.
  /// Returns a [NoteEntity] if found, or null if not found.
  /// Throws an exception if the fetch fails.
  /// @param noteId The ID of the note to fetch.
  Future<NoteEntity?> getNoteDetail(int noteId);
  
  /// Adds a new note.
  /// Returns the ID of the newly added note.
  Future<int> addNote(NoteEntity note);


  /// Deletes a note by its ID.
  Future<bool> deleteNote(int noteId); 

  /// Updates an existing note.
  Future<bool> updateNote(NoteEntity note);

  /// Filters notes by title based on the provided query.
  Future<List<NoteEntity>> filterNoteByTitle(String query); 
}
