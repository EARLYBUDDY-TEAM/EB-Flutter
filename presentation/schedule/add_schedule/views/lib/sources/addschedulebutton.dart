part of '../eb_add_schedule.dart';

class _AddScheduleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
      child: BlocSelector<AddScheduleBloc, AddScheduleState, AddScheduleStatus>(
        selector: (state) => state.status,
        builder: (context, status) {
          return EBButton(
            name: '일정 등록',
            onPressed: status == AddScheduleStatus.complete
                ? () {
                    context
                        .read<AddScheduleBloc>()
                        .add(const PressAddScheduleButton());
                  }
                : null,
          );
        },
      ),
    );
  }
}
