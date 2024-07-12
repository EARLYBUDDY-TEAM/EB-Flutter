import 'package:earlybuddy/presentation/schedule/addschedule/bloc/addschedule_bloc.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScheduleExample extends StatelessWidget {
  const AddScheduleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddScheduleBloc(),
      child: const MaterialApp(
        home: AddScheduleView(),
      ),
    );
  }
}
