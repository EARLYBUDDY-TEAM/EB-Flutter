import 'package:earlybuddy/domain/delegate/searchplace_delegate.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/repository/schedule/schedule_repository.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/bloc/bloc.dart';
import 'package:earlybuddy/presentation/schedule/findroute/view/findroute_view.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/bloc/bloc.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/searchplace.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'appbar.dart';
part 'forms/addschedule_forms.dart';
part 'forms/name.dart';
part 'forms/time/time.dart';
part 'forms/time/datepicker.dart';
part 'forms/time/timepicker.dart';
part 'forms/notify.dart';
part 'forms/place.dart';
part 'forms/route.dart';
part 'helper/icon_plus_name.dart';
part 'helper/round_rect_form.dart';
part 'addschedulebutton.dart';

final class AddScheduleView extends StatelessWidget {
  AddScheduleState? state;

  AddScheduleView({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddScheduleBloc(
        addScheduleState: state,
        searchPlaceDelegateForPlace:
            RepositoryProvider.of<SearchPlaceDelegateForPlace>(context),
        searchPlaceDelegateForRoute:
            RepositoryProvider.of<SearchPlaceDelegateForRoute>(context),
        scheduleRepository: RepositoryProvider.of<ScheduleRepository>(context),
      ),
      child: const _AddScheduleContent(),
    );
  }
}

final class _AddScheduleContent extends StatelessWidget {
  final double fontSize = 17;

  const _AddScheduleContent();

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
