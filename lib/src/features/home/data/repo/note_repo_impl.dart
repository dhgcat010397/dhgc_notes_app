import 'package:dhgc_notes_app/src/features/home/data/datasources/local/note_local_datasource.dart';
import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/domain/repo/note_repo.dart';

class NoteRepoImpl implements NoteRepo {
  // final NoteRemoteDataSource _remoteDataSource;
  final NoteLocalDatasource localDataSource;

  NoteRepoImpl(this.localDataSource);

  @override
  Future<List<NoteEntity>> fetchNotesList() async =>
      await localDataSource.fetchNotesList();

  @override
  Future<List<NoteEntity>> filterNoteByTitle(String query) async =>
      await localDataSource.filterNoteByTitle(query);

  @override
  Future<NoteEntity?> getNoteDetail(int noteId) async =>
      await localDataSource.getNoteDetail(noteId);

  @override
  Future<int> addNote(NoteEntity note) async =>
      await localDataSource.addNote(note);

  @override
  Future<bool> deleteNote(int noteId) async =>
      await localDataSource.deleteNote(noteId);

  @override
  Future<bool> updateNote(NoteEntity note) async =>
      await localDataSource.updateNote(note);
}
