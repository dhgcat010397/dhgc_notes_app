import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/domain/repo/note_repo.dart';

class UpdateNoteUsecase {
  final NoteRepo _repo;

  UpdateNoteUsecase(this._repo);

  Future<bool> call(NoteEntity note) async => await _repo.updateNote(note);
}
