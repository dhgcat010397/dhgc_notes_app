import 'package:dhgc_notes_app/src/features/home/data/datasources/local/note_local_datasource.dart';
import 'package:dhgc_notes_app/src/features/home/data/datasources/local/note_local_datasource_impl.dart';
import 'package:dhgc_notes_app/src/features/home/data/repo/note_repo_impl.dart';
import 'package:dhgc_notes_app/src/features/home/domain/repo/note_repo.dart';
import 'package:dhgc_notes_app/src/core/utils/dependencies_injection.dart';
import 'package:dhgc_notes_app/src/features/home/domain/usecases/get_note_detail_usecase.dart';
import 'package:dhgc_notes_app/src/features/home/domain/usecases/get_notes_list_usecase.dart';
import 'package:dhgc_notes_app/src/features/home/presentation/bloc/note_bloc.dart';

Future<void> noteInjectionContainer() async {
  // Register the NoteLocalDatasource
  sl.registerLazySingleton<NoteLocalDatasource>(
    () => NoteLocalDatasourceImpl(),
  );

  // Register the NoteRepo
  sl.registerLazySingleton<NoteRepo>(() => NoteRepoImpl(sl()));

  // Register the use cases
  sl.registerLazySingleton<GetNotesListUsecase>(
    () => GetNotesListUsecase(sl()),
  );

  // Register the GetNoteDetailUsecase
  sl.registerLazySingleton<GetNoteDetailUsecase>(
    () => GetNoteDetailUsecase(sl()),
  );

  // Register the NoteBloc
  sl.registerFactory<NoteBloc>(
    () => NoteBloc(
      getNotesListUseCase: sl(),
      getNoteDetailUseCase: sl(),
      filterNotesByTitleUseCase: sl(),
      addNoteUseCase: sl(),
      deleteNoteUseCase: sl(),
      updateNoteUseCase: sl(),
    ),
  );
}
