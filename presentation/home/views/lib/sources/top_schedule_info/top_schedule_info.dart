part of '../../eb_home.dart';

final class _TopScheduleInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return previous.topScheduleInfoState != current.topScheduleInfoState;
      },
      builder: (context, state) {
        switch (state.topScheduleInfoState) {
          case NoneTopScheduleState():
            final noneState =
                state.topScheduleInfoState as NoneTopScheduleState;
            return _NoneTopScheduleInfoView(
              upcomingSchedule: noneState.upcomingSchedule,
            );
          case TodayTopScheduleState():
            final todayState =
                state.topScheduleInfoState as TodayTopScheduleState;
            return _TodayTopScheduleInfoView(
              nextSchedulePath: todayState.nextSchedulePath,
            );
        }
      },
    );
  }
}
