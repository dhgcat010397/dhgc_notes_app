import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';
import 'package:dhgc_notes_app/src/features/home/domain/repo/note_repo.dart';

class AddNoteUsecase {
  final NoteRepo _repo;

  AddNoteUsecase(this._repo);

  Future<int> call(NoteEntity note) async => await _repo.addNote(note);
}
