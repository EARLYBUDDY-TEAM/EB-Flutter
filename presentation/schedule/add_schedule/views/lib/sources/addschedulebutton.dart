part of '../eb_add_schedule.dart';

final class _AddScheduleButton extends StatelessWidget {
  final double bottomPadding;

  const _AddScheduleButton({
    super.key,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddScheduleBloc, AddScheduleState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: bottomPadding,
          ),
          child: EBButton(
            name: '일정 등록',
            onPressed: state.status == FormStatus.complete
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
