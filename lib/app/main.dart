import 'dart:developer';

import 'package:earlybuddy/presentation/schedule/addschedule/example/addschedule_example.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/example/searchplace_example.dart';
import 'package:earlybuddy/presentation/schedule/selectroute/example/selectroute_example.dart';

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

  // runApp(const SearchPlaceExample());
  // runApp(const AddScheduleExample());
  runApp(const SelectRouteExample());

  // runApp(const TestStackPositionedExample());
}

Future<void> initializeKakaoMap() async {
  await dotenv.load(fileName: 'assets/env/.env');
  AuthRepository.initialize(
    appKey: dotenv.env['APP_KEY'] ?? '',
    baseUrl: dotenv.env['BASE_URL'] ?? '',
  );
}

class TestStackPositionedExample extends StatelessWidget {
  const TestStackPositionedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StackPositionedExample(),
    );
  }
}

class StackPositionedExample extends StatelessWidget {
  const StackPositionedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 5, color: Colors.lightGreenAccent)),
          child: Stack(
            children: [
              Positioned(
                left:
                    50, // distance between this child's left edge & left edge of stack
                top:
                    150, // distance between this child's top edge & top edge of stack
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.blue,
                  alignment: Alignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
