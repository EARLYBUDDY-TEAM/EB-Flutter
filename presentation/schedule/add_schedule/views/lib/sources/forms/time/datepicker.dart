part of '../../../eb_add_schedule.dart';

final class _DatePicker extends StatefulWidget {
  final DateTime initialDate;

  const _DatePicker({
    super.key,
    required this.initialDate,
  });

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

final class _DatePickerState extends State<_DatePicker> {
  late DateTime _selectedDate;

  void _setInitialDate() {
    _selectedDate = widget.initialDate;
  }

  @override
  void didUpdateWidget(covariant _DatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialDate != widget.initialDate) {
      _setInitialDate();
    }
  }

  @override
  void initState() {
    super.initState();
    _setInitialDate();
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
        final DateTime? date = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
          initialDate: _selectedDate,
          locale: const Locale('ko'),
        );

        if (date != null) {
          setState(() {
            _selectedDate = date;
          });
        }
      },
      child: Text(
        dateString,
        style: TextStyle(
          fontFamily: FontFamily.nanumSquareBold,
          color: EBColors.text,
          fontSize: 13,
        ),
      ),
    );
  }

  String get dateString {
    String year = '${_selectedDate.year}년';
    final m = _selectedDate.month;
    String month = m < 10 ? '0$m' : '$m';
    month += '월';
    final d = _selectedDate.day;
    String day = d < 10 ? '0$d' : '$d';
    day += '일';
    String weekday = '(${_toWeekDay[_selectedDate.weekday]})';
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
