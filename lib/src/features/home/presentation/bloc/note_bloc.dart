import 'dart:async';

import 'package:dhgc_notes_app/src/features/home/domain/usecases/get_note_detail_usecase.dart';
import 'package:dhgc_notes_app/src/features/home/domain/usecases/get_notes_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dhgc_notes_app/src/features/home/domain/entities/note_entity.dart';

part "note_state.dart";
part "note_event.dart";

part 'note_bloc.freezed.dart'; // run: flutter pub run build_runner build --delete-conflicting-outputs

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotesListUsecase getNotesListUseCase;
  final GetNoteDetailUsecase getNoteDetailUseCase;
  List<NoteEntity> _notesList = [], _notesListFiltered = [];

  NoteBloc({
    required this.getNotesListUseCase,
    required this.getNoteDetailUseCase,
  }) : super(const _Initial()) {
    on<NoteEvent>(
      (event, emit) => event.map(
        fetchNotesList: (event) => _onFetchNotesList(emit),
        getNoteDetail: (event) => _onGetNoteDetail(event.noteId, emit),
        filterNoteByTitle: (event) => _onFilterNoteByTitle(event.query, emit),
      ),
    );
  }

  Future<void> _onFetchNotesList(Emitter<NoteState> emit) async {
    emit(const _Loading());

    try {
      // _notesList = await getProductsListUseCase.call();
      emit(_Loaded(notesList: _notesList));
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }

  Future<void> _onGetNoteDetail(int noteId, Emitter<NoteState> emit) async {
    emit(const _Loading());

    try {
      // final note = await getProductDetailUseCase.call(noteId);
      // if (note == null) {
      //   emit(const _Error(errorCode: 404, errorMessage: "Product not found"));
      // } else {
      //   emit(
      //     _Loaded(
      //       notesList:
      //           _notesListFiltered.isEmpty
      //               ? _notesList
      //               : _notesListFiltered,
      //       noteDetail: note,
      //     ),
      //   );
      // }
      emit(_Loaded(notesList: _notesList));
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }

  Future<void> _onFilterNoteByTitle(
    String query,
    Emitter<NoteState> emit,
  ) async {
    emit(const _Loading());

    try {
      if (query.isEmpty) {
        _notesListFiltered = [];
        emit(_Loaded(notesList: _notesList));
      } else {
        final cleanedQuery = query.trim().replaceAll(RegExp(r'\s+'), ' ');
        final notes = _notesList;
        _notesListFiltered =
            notes
                .where(
                  (p) => p.title.toLowerCase().contains(
                    cleanedQuery.toLowerCase(),
                  ),
                )
                .toList();
        emit(_Loaded(notesList: _notesListFiltered));
      }
    } catch (e) {
      emit(_Error(errorCode: e.hashCode, errorMessage: e.toString()));
    }
  }
}
