part of '../addschedule_view.dart';

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

final class _DatePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

final class _DatePickerState extends State<_DatePicker> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () async {
        final DateTime? date = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
          initialDate: selectedDate,
        );

        if (date != null) {
          setState(() {
            selectedDate = date;
          });
        }
      },
      child: Text(
        dateString,
        style: TextStyle(
          fontFamily: NanumSquare.bold,
          color: EBColors.text,
          fontSize: 13,
        ),
      ),
    );
  }

  String get dateString {
    String year = '${selectedDate.year}년';
    final m = selectedDate.month;
    String month = m < 10 ? '0$m' : '$m';
    month += '월';
    final d = selectedDate.day;
    String day = d < 10 ? '0$d' : '$d';
    day += '일';
    String weekday = '(${_toWeekDay[selectedDate.weekday]})';
    return '$year $month $day $weekday';
  }

  final _toWeekDay = {
    1: '월',
    2: '화',
    3: '수',
    4: '목',
    5: '금',
    6: '토',
    7: '일',
  };
}

final class _TimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimePickerState();
}

final class _TimePickerState extends State<_TimePicker> {
  var selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        timePickerTheme: _ebTimePickerThemeData,
        textButtonTheme: _ebTextButtonThemeData,
      ),
      child: Builder(
        builder: (context) {
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
        },
      ),
    );
  }

  TimePickerThemeData get _ebTimePickerThemeData {
    return TimePickerThemeData(
      hourMinuteColor: EBColors.purple1.withOpacity(0.3),
      dayPeriodColor: EBColors.purple2.withOpacity(0.15),
      dialHandColor: EBColors.purple1,
    );
  }

  TextButtonThemeData get _ebTextButtonThemeData {
    return TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith((states) {
          return const TextStyle(
            fontFamily: NanumSquare.extraBold,
          );
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          return EBColors.purple2;
        }),
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
