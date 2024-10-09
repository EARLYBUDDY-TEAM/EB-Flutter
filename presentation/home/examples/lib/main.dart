import 'package:flutter/material.dart';
import 'sources/home_example.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:eb_secure_storage/eb_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await prepareAccessToken();

  runApp(const MockHomeCalendar());

  // runApp(const MockBottomScheduleCardExample());

  // runApp(const HomeExample());

  // runApp(MockHomeView());

  // await Future<void>.delayed(const Duration(seconds: 2));
  // homeDelegate.loginStatus.add(BaseStatus.success);
}

Future<void> prepareAccessToken() async {
  final secureStorage = SecureStorage();
  await secureStorage.write(key: SecureStorageKey.accessToken, value: "");
}
