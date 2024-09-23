import 'package:flutter/material.dart';
import 'sources/home_example.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:eb_uikit/eb_uikit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(const HomeExample());

  await Future<void>.delayed(const Duration(seconds: 2));
  homeDelegate.loginStatus.add(BaseStatus.success);
}
