import 'package:earlybuddy/presentation/addschedule/bloc/addschedule_bloc.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addschedule_appbar.dart';
part 'addschedule_forms.dart';
part 'forms/name_form.dart';
part 'forms/time_form.dart';
part 'forms/notify_form.dart';
part 'forms/place_form.dart';
part 'forms/route_form.dart';
part 'helper/icon_plus_name.dart';
part 'helper/round_rect_form.dart';
part 'addschedule_button.dart';

class AddScheduleView extends StatelessWidget {
  final double fontSize = 17;

  const AddScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddScheduleBloc(),
      child: Scaffold(
        appBar: _AppBar(context: context),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _AddScheduleForms(),
              _AddScheduleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
