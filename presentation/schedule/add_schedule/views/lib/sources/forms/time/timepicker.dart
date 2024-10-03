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
        EBTime.toHour(selectedTime),
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          color: EBColors.text,
          fontSize: 17,
        ),
      ),
    );
  }
}
