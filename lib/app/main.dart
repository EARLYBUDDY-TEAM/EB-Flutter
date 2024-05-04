import 'package:earlybuddy/presentation/schedule/addschedule/example/addschedule_example.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // runApp(const App());
  runApp(const ExampleAddSchedule());
}
