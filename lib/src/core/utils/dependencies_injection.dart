import 'package:dhgc_notes_app/src/features/home/note_injection_container.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await noteInjectionContainer();
}