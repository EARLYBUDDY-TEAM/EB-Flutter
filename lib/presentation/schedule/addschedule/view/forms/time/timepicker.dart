part of '../../addschedule_view.dart';

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
          fontFamily: NanumSquare.bold,
          color: EBColors.text,
          fontSize: 17,
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Theme(
  //     data: ThemeData(
  //       timePickerTheme: _timePickerThemeData,
  //       textButtonTheme: _textButtonThemeData,
  //     ),
  //     child: Builder(
  //       builder: (context) {
  //         return TextButton(
  //           style: TextButton.styleFrom(
  //             minimumSize: Size.zero,
  //             padding: EdgeInsets.zero,
  //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           ),
  //           onPressed: () async {
  //             final TimeOfDay? time = await showTimePicker(
  //               context: context,
  //               initialTime: selectedTime,
  //             );

  //             if (time != null) {
  //               setState(() {
  //                 selectedTime = time;
  //               });
  //             }
  //           },
  //           child: Text(
  //             timeString,
  //             style: TextStyle(
  //               fontFamily: NanumSquare.bold,
  //               color: EBColors.text,
  //               fontSize: 17,
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // TimePickerThemeData get _timePickerThemeData {
  //   return TimePickerThemeData(
  //     hourMinuteColor: EBColors.purple1.withOpacity(0.4),
  //     dialHandColor: EBColors.purple1,
  //   );
  // }

  // TextButtonThemeData get _textButtonThemeData {
  //   return TextButtonThemeData(
  //     style: ButtonStyle(
  //       textStyle: WidgetStateProperty.resolveWith((states) {
  //         return const TextStyle(
  //           fontFamily: NanumSquare.extraBold,
  //         );
  //       }),
  //       foregroundColor: WidgetStateProperty.resolveWith((states) {
  //         return EBColors.purple2;
  //       }),
  //     ),
  //   );
  // }

  String get timeString {
    String meridiem = selectedTime.hour < 12 ? '오전' : '오후';
    final m = selectedTime.minute;
    String minute = m < 10 ? '0$m' : '$m';
    return '$meridiem ${selectedTime.hour}:$minute';
  }
}
