import 'package:earlybuddy/domain/delegate/searchplace.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/bloc/bloc.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/view/addschedule_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mock_addschedule.dart';

final class AddScheduleExample extends StatelessWidget {
  const AddScheduleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MockAddSchedule();
  }
}
