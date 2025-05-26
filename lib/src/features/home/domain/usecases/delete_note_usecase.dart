import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/domain/repo/note_repo.dart';

class DeleteNoteUsecase {
  final NoteRepo _repo;

  DeleteNoteUsecase(this._repo);

  Future<bool> call(int noteId) async => await _repo.deleteNote(noteId);
}
