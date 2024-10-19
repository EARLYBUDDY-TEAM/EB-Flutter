part of '../../../eb_add_schedule.dart';

final class NotifyScheduleExpanded extends StatelessWidget {
  const NotifyScheduleExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _divider(),
        _selectBeforeNotifyMinuteView(),
      ],
    );
  }

  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
    );
  }

  Widget _selectBeforeNotifyMinuteView() {
    return const Row(
      children: [
        Text(
          '일정 시작 알림',
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareRegular,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
