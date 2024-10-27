part of '../../../eb_add_schedule.dart';

final class _TimePicker extends StatefulWidget {
  final TimeOfDay initialTime;

  const _TimePicker({
    super.key,
    required this.initialTime,
  });

  @override
  State<StatefulWidget> createState() => _TimePickerState();
}

final class _TimePickerState extends State<_TimePicker> {
  late TimeOfDay _selectedTime;

  void _setSelctedTime() {
    _selectedTime = widget.initialTime;
  }

  @override
  void didUpdateWidget(covariant _TimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialTime != widget.initialTime) {
      _setSelctedTime();
    }
  }

  @override
  void initState() {
    super.initState();
    _setSelctedTime();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
        );

        if (time != null) {
          setState(() {
            context.read<AddScheduleBloc>().add(ChangeTime(time: time));
            _selectedTime = time;
          });
        }
      },
      child: Text(
        EBTime.toHour(_selectedTime),
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          color: EBColors.text,
          fontSize: 17,
        ),
      ),
    );
  }
}
