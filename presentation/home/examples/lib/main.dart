import 'package:flutter/material.dart';
import 'sources/home_example.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(const HomeExample());
}
