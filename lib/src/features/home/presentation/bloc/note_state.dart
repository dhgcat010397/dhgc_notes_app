part of "note_bloc.dart";

@freezed
abstract class NoteState with _$NoteState {
  const factory NoteState.initial() = _Initial;
  const factory NoteState.loading() = _Loading;
  const factory NoteState.loaded({
    @Default([]) List<NoteEntity> notesList,
    @Default(null) NoteEntity? noteDetail,
    @Default(false) bool isAdded,
    @Default(false) bool isUpdated,
    @Default(false) bool isDeleted,
  }) = _Loaded;
  const factory NoteState.error({
    required int errorCode,
    required String errorMessage,
  }) = _Error;
}
