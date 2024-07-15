import 'dart:developer';

import 'package:earlybuddy/domain/delegate/searchplace.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/bloc/bloc.dart';
import 'package:earlybuddy/presentation/schedule/findroute/view/findroute_view.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/bloc/bloc.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/searchplace.dart';
import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'appbar.dart';
part 'forms/addschedule_forms.dart';
part 'forms/name.dart';
part 'forms/time.dart';
part 'forms/notify.dart';
part 'forms/place.dart';
part 'forms/route.dart';
part 'helper/icon_plus_name.dart';
part 'helper/round_rect_form.dart';
part 'addschedulebutton.dart';

class AddScheduleView extends StatelessWidget {
  final double fontSize = 17;

  const AddScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
