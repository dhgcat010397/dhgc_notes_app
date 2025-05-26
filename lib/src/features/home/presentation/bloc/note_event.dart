part of "note_bloc.dart";

@freezed
abstract class NoteEvent with _$NoteEvent {
  const factory NoteEvent.fetchNotesList() = _FetchNotesList;
  const factory NoteEvent.getNoteDetail(int noteId) = _GetNoteDetail;
  const factory NoteEvent.filterNotesByTitle(String query) =
      _FilterNotesByTitle;
  const factory NoteEvent.addNote({
    required String title,
    required String content,
  }) = _AddNote;
  const factory NoteEvent.deleteNote(int noteId) = _DeleteNote;
  const factory NoteEvent.updateNote(NoteEntity note) = _UpdateNote;
}
