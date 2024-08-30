import 'package:eb_model/entity.dart';
import 'package:eb_add_schedule_feature/eb_add_schedule_feature.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_add_schedule/eb_add_schedule.dart';
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
