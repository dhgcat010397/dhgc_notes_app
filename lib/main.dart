import 'package:dhgc_notes_app/src/core/helpers/database_helper.dart';
import 'package:flutter/material.dart';

import 'package:dhgc_notes_app/src/app.dart';
import 'package:dhgc_notes_app/src/core/utils/dependencies_injection.dart'
    as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  await di.initInjections();

  runApp(const MyApp());
}
