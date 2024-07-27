part of '../../addschedule_view.dart';

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

  // @override
  // Widget build(BuildContext context) {
  //   return Theme(
  //     data: ThemeData(
  //       colorScheme: ColorScheme.light(
  //         primary: EBColors.purple1,
  //         onPrimary: EBColors.text,
  //         onSurface: EBColors.text,
  //       ),
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
  //             final DateTime? date = await showDatePicker(
  //               context: context,
  //               firstDate: DateTime(2000),
  //               lastDate: DateTime(3000),
  //               initialDate: selectedDate,
  //             );

  //             if (date != null) {
  //               setState(() {
  //                 selectedDate = date;
  //               });
  //             }
  //           },
  //           child: Text(
  //             dateString,
  //             style: TextStyle(
  //               fontFamily: NanumSquare.bold,
  //               color: EBColors.text,
  //               fontSize: 13,
  //             ),
  //           ),
  //         );
  //       },
  //     ),
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
