import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/domain/repo/note_repo.dart';

class GetNotesListUsecase {
  final NoteRepo _repo;

  GetNotesListUsecase(this._repo);

  Future<List<NoteEntity>> call() async => await _repo.fetchNotesList();
}
