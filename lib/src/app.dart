import 'package:dhgc_notes_app/src/features/home/presentation/bloc/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dhgc_notes_app/src/core/routes/app_routes.dart';
import 'package:dhgc_notes_app/src/core/routes/route_generator.dart';
import 'package:dhgc_notes_app/src/features/home/presentation/views/home_page.dart';
import 'package:dhgc_notes_app/src/core/utils/dependencies_injection.dart'
    as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<NoteBloc>()..add(NoteEvent.fetchNotesList()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        onGenerateRoute: RouteGenerator.generateRoute,
        onGenerateInitialRoutes:
            (initialRoute) => [
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const HomePage(),
                transitionsBuilder:
                    (_, animation, __, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ],
      ),
    );
  }
}
