part of '../../../eb_add_schedule.dart';

class ScheduleNameForm extends StatelessWidget {
  final Color color = Colors.grey;
  final double fontSize;

  const ScheduleNameForm({
    super.key,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RoundRectForm(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          children: [
            _ScheduleTitleInput(
              color: color,
              fontSize: fontSize,
            ),
            _ScheduleMemoInput(
              color: color,
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}
