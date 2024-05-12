import 'dart:developer';

import 'package:earlybuddy/presentation/schedule/addschedule/example/addschedule_example.dart';
import 'package:earlybuddy/presentation/schedule/kakaomap/example/kakaomap_example.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/example/searchplace_example.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await initializeKakaoMap();

  // runApp(const App());
  // runApp(const ExampleAddSchedule());
  // runApp(const KakaoMapExample());
  // await getlocationd

  runApp(const SearchPlaceExample());
}

Future<void> initializeKakaoMap() async {
  await dotenv.load(fileName: 'assets/env/.env');
  AuthRepository.initialize(
    appKey: dotenv.env['APP_KEY'] ?? '',
    baseUrl: dotenv.env['BASE_URL'] ?? '',
  );
}
