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
          case NoneTopScheduleInfoState():
            final noneState =
                state.topScheduleInfoState as NoneTopScheduleInfoState;
            return _NoneTopScheduleInfoView(
              upcomingSchedule: noneState.upcomingSchedule,
            );
          case TodayTopScheduleInfoState():
            final todayState =
                state.topScheduleInfoState as TodayTopScheduleInfoState;
            return _TodayTopScheduleInfoView(
              nextSchedulePath: todayState.nextSchedulePath,
            );
        }
      },
    );
  }
}
