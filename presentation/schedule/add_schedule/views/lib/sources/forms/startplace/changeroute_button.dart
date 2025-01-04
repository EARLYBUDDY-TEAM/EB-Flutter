part of '../../../eb_add_schedule.dart';

final class ChangeRouteButton extends StatelessWidget {
  const ChangeRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddScheduleBloc, AddScheduleState>(
      buildWhen: (previous, current) {
        final flag1 = (current.startPlaceState is SelectedStartPlaceState);
        final flag2 = (previous.startPlaceState != current.startPlaceState);
        return (flag1 && flag2);
      },
      builder: (context, state) {
        final startPlaceState =
            state.startPlaceState as SelectedStartPlaceState;
        final startPlace = startPlaceState.pathInfo.startPlace;
        final endPlace = startPlaceState.pathInfo.endPlace;
        final scheduleTime = state.schedule.time;

        return EBRoundedButton(
          text: "경로 변경",
          onPressed: () {
            showCupertinoModalBottomSheet(
              context: context,
              expand: true,
              backgroundColor: Colors.white,
              builder: builderModalBottomSheetWithRoute(
                context: context,
                onGenerateRoute: AddScheduleView.pageWriteFindRoute(
                  context: context,
                  startPlace: startPlace,
                  endPlace: endPlace,
                  scheduleTime: scheduleTime,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
