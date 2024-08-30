part of '../../../eb_add_schedule.dart';

class _TimeForm extends StatelessWidget {
  final double fontSize;

  const _TimeForm({
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return _RoundRectForm(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _IconPlusName(
              name: '시간',
              iconData: Icons.access_time,
              fontSize: fontSize,
              isActive: true,
            ),
            const Spacer(),
            _DatePicker(),
            const SizedBox(width: 7),
            _TimePicker(),
          ],
        ),
      ),
    );
  }
}
