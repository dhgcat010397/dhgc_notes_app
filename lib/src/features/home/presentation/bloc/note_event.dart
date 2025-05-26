part of "note_bloc.dart";

@freezed
abstract class NoteEvent with _$NoteEvent {
  const factory NoteEvent.fetchNotesList() = _FetchNotesList;
  const factory NoteEvent.getNoteDetail(int noteId) = _GetNoteDetail;
  const factory NoteEvent.filterNoteByTitle(String query) = _FilterProductByTitle;
//   const factory NoteEvent.addNote(NoteEntity note) = _AddNote;
//   const factory NoteEvent.updateNote(NoteEntity note) = _UpdateNote;
//   const factory NoteEvent.deleteNote(int noteId) = _DeleteNote;
}
