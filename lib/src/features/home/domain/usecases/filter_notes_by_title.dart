import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/domain/repo/note_repo.dart';

class FilterNotesByTitleUsecase {
  final NoteRepo _repo;

  FilterNotesByTitleUsecase(this._repo);

  Future<List<NoteEntity>> call(String query) async =>
      await _repo.filterNoteByTitle(query);
}
