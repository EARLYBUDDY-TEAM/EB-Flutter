import 'package:eb_add_schedule_feature/eb_add_schedule_feature.dart';
import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_add_schedule/eb_add_schedule.dart';
import 'package:eb_event/eb_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_state/eb_state.dart';
import 'package:eb_model/entity.dart';

part 'mock_addschedule_view.dart';
part 'mock_schedule_name_form.dart';

final class AddScheduleExample extends StatelessWidget {
  const AddScheduleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MockAddScheduleView();
  }
}
