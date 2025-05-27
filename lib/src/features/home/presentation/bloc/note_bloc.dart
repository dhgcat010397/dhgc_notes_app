import 'dart:async';

import 'package:dhgc_notes_app/src/features/home/domain/usecases/add_note_usecase.dart';
import 'package:dhgc_notes_app/src/features/home/domain/usecases/delete_note_usecase.dart';
import 'package:dhgc_notes_app/src/features/home/domain/usecases/filter_notes_by_title.dart';
import 'package:dhgc_notes_app/src/features/home/domain/usecases/get_note_detail_usecase.dart';
import 'package:dhgc_notes_app/src/features/home/domain/usecases/get_notes_list_usecase.dart';
import 'package:dhgc_notes_app/src/features/home/domain/usecases/update_note_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';

part "note_state.dart";
part "note_event.dart";

part 'note_bloc.freezed.dart'; // run: flutter pub run build_runner build --delete-conflicting-outputs

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotesListUsecase getNotesListUseCase;
  final GetNoteDetailUsecase getNoteDetailUseCase;
  final FilterNotesByTitleUsecase filterNotesByTitleUseCase;
  final AddNoteUsecase addNoteUseCase;
  final DeleteNoteUsecase deleteNoteUseCase;
  final UpdateNoteUsecase updateNoteUseCase;

  List<NoteEntity> _notesList = [];
  String _cleanedQuery = "";

  NoteBloc({
    required this.getNotesListUseCase,
    required this.getNoteDetailUseCase,
    required this.filterNotesByTitleUseCase,
    required this.addNoteUseCase,
    required this.deleteNoteUseCase,
    required this.updateNoteUseCase,
  }) : super(const _Initial()) {
    on<NoteEvent>(
      (event, emit) => event.map(
        fetchNotesList: (event) => _onFetchNotesList(emit),
        getNoteDetail: (event) => _onGetNoteDetail(event.noteId, emit),
        filterNotesByTitle: (event) => _onFilterNotesByTitle(event.query, emit),
        addNote: (event) => _onAddNote(event.title, event.content, emit),
        deleteNote: (event) => _onDeleteNote(event.noteId, emit),
        updateNote: (event) => _onUpdateNote(event.note, emit),
      ),
    );
  }

  Future<void> _onFetchNotesList(Emitter<NoteState> emit) async {
    emit(const _Loading());

    try {
      _notesList = await getNotesListUseCase.call();
      emit(_Loaded(notesList: _notesList));
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }

  Future<void> _onGetNoteDetail(int noteId, Emitter<NoteState> emit) async {
    emit(const _Loading());

    try {
      final note = await getNoteDetailUseCase.call(noteId);

      if (note == null) {
        emit(const _Error(errorCode: 404, errorMessage: "Note not found"));
      } else {
        emit(_Loaded(notesList: _notesList, noteDetail: note));
      }
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }

  Future<void> _onFilterNotesByTitle(
    String query,
    Emitter<NoteState> emit,
  ) async {
    emit(const _Loading());

    try {
      if (query.isEmpty) {
        emit(_Loaded(notesList: _notesList));
      } else {
        _cleanedQuery =
            query.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();

        _notesList = await filterNotesByTitleUseCase.call(_cleanedQuery);

        emit(_Loaded(notesList: _notesList));
      }
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }

  Future<void> _onAddNote(String title, String content, Emitter<NoteState> emit) async {
    try {
      final note = NoteEntity(
        id: null, // ID will be set by the database
        title: title.trim(),
        content: content.trim(),
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );
      final noteId = await addNoteUseCase.call(note);

      if (noteId > -1) {
        _notesList = await filterNotesByTitleUseCase.call(_cleanedQuery);

        emit(_Loaded(notesList: _notesList, isAdded: true));
      } else {
        emit(const _Error(errorCode: 500, errorMessage: "Add note failed"));
      }
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }

  Future<void> _onDeleteNote(int noteId, Emitter<NoteState> emit) async {
    try {
      final isDeleted = await deleteNoteUseCase.call(noteId);

      if (isDeleted) {
        _notesList = await filterNotesByTitleUseCase.call(_cleanedQuery);

        emit(_Loaded(notesList: _notesList, isDeleted: true));
      } else {
        emit(const _Error(errorCode: 500, errorMessage: "Delete note failed"));
      }
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateNote(NoteEntity note, Emitter<NoteState> emit) async {
    try {
      final isUpdated = await updateNoteUseCase.call(note);

      if (isUpdated) {
        _notesList = await filterNotesByTitleUseCase.call(_cleanedQuery);

        emit(_Loaded(notesList: _notesList, isUpdated: true));
      } else {
        emit(const _Error(errorCode: 500, errorMessage: "Update note failed"));
      }
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }
}
