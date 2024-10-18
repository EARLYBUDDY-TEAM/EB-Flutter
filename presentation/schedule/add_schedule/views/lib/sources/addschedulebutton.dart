part of '../eb_add_schedule.dart';

class _AddScheduleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddScheduleBloc, AddScheduleState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: EBButton(
            name: '일정 등록',
            onPressed: state.status == ScheduleInfoStatus.complete
                ? () {
                    context
                        .read<AddScheduleBloc>()
                        .add(const PressAddScheduleButton());
                  }
                : null,
          ),
        );
      },
    );
  }
}
