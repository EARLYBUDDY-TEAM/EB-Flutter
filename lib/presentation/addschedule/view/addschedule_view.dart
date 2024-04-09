import 'package:earlybuddy/shared/eb_resources/eb_resources.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'addschedule_appbar.dart';
part 'addschedule_forms.dart';
part 'forms/addschedule_nameform.dart';
part 'forms/addschedule_timeform.dart';
part 'forms/addschedule_alertform.dart';
part 'forms/addschedule_placeform.dart';
part 'forms/addschedule_routeform.dart';
part 'forms/helper/addschedule_icon_plus_name.dart';
part 'forms/helper/addschedule_roundrect_form.dart';
part 'addschedule_button.dart';

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
            _Forms(),
            _AddScheduleButton(),
          ],
        ),
      ),
    );
  }
}
