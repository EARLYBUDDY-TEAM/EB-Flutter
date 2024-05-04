import 'package:earlybuddy/presentation/schedule/addschedule/view/view.dart';
import 'package:flutter/material.dart';

class ExampleAddSchedule extends StatelessWidget {
  const ExampleAddSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: AddScheduleView(),
      ),
    );
  }
}
