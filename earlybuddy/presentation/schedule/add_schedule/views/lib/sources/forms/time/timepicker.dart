part of '../../../eb_add_schedule.dart';

final class _TimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimePickerState();
}

final class _TimePickerState extends State<_TimePicker> {
  var selectedTime = TimeOfDay.now();

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
          initialTime: selectedTime,
        );

        if (time != null) {
          setState(() {
            selectedTime = time;
          });
        }
      },
      child: Text(
        timeString,
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          color: EBColors.text,
          fontSize: 17,
        ),
      ),
    );
  }

  String get timeString {
    String meridiem = selectedTime.hour < 12 ? '오전' : '오후';
    final m = selectedTime.minute;
    String minute = m < 10 ? '0$m' : '$m';
    return '$meridiem ${selectedTime.hour}:$minute';
  }
}
