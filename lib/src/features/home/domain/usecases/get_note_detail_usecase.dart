import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/domain/repo/note_repo.dart';

class GetNoteDetailUsecase {
  final NoteRepo _repo;

  GetNoteDetailUsecase(this._repo);

  Future<NoteEntity?> call(int noteId) async => await _repo.getNoteDetail(noteId);
}
