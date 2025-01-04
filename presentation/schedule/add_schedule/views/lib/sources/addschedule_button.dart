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
            bottom: _calBottomPadding(
              context: context,
              bottomPadding: bottomPadding,
            ),
          ),
          child: EBButton(
            name: _name(state.setting),
            onPressed: onPressed(
              context: context,
              status: state.status,
            ),
          ),
        );
      },
    );
  }

  double _calBottomPadding({
    required BuildContext context,
    required double bottomPadding,
  }) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final newBottomPadding = keyboardHeight + 20;
    return newBottomPadding;
  }

  String _name(SealedAddScheduleSetting setting) {
    return (setting is InitAddScheduleSetting) ? '일정 등록' : '일정 수정';
  }

  Function()? onPressed({
    required BuildContext context,
    required FormStatus status,
  }) {
    return status == FormStatus.complete
        ? () {
            context.read<AddScheduleBloc>().add(const PressAddScheduleButton());
          }
        : null;
  }
}
