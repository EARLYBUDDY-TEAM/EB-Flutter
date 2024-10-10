part of '../../eb_home.dart';

final class HomeCalendar extends StatefulWidget {
  const HomeCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _HomeCalendarState();
}

final class _HomeCalendarState extends State<HomeCalendar> {
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final DateTime _firstDay = DateTime.utc(2020, 01, 01);
  final DateTime _lastDay = DateTime.utc(2030, 01, 01);
  DateTime? _selectedDay;

  final double _dayFontSize = 16;
  final double _weekFontSize = 13;
  final double _dayCellTopPadding = 10;
  final double _selectDayCellBordorWidth = 1.5;
  final _animateDuration = const Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return _HomeCalendarHeader(focusedDay: value);
            },
          ),
        ),
        const SizedBox(height: 20),
        TableCalendar(
          rowHeight: 70,
          daysOfWeekHeight: 40,
          headerVisible: false,
          daysOfWeekStyle: _daysOfWeekStyle,
          focusedDay: _focusedDay.value,
          firstDay: _firstDay,
          lastDay: _lastDay,
          locale: EBLocale.ko_KR.name,
          onDaySelected: _onDaySelected,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarBuilders: CalendarBuilders(
            selectedBuilder: _selectedBuilder,
            defaultBuilder: _defaultBuilder,
            // todayBuilder: _todayBuilder,
            // outsideBuilder: _outsideBuilder,
            // disabledBuilder: _defaultBuilder,
          ),
        ),
      ],
    );
  }
}

// ui
extension on _HomeCalendarState {
  Widget _dayCell({
    required DateTime dayTime,
    required Color color,
  }) {
    final padding =
        EdgeInsets.only(top: _dayCellTopPadding + _selectDayCellBordorWidth);
    const alignment = Alignment.topCenter;
    final margin = EdgeInsets.only(
      left: _dayCellTopPadding,
      right: _dayCellTopPadding,
      bottom: _dayCellTopPadding * 2,
    );

    const decoration = ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(20),
        ),
      ),
    );

    return AnimatedContainer(
      duration: _animateDuration,
      margin: margin,
      decoration: decoration,
      padding: padding,
      alignment: alignment,
      child: _dayText(dayTime: dayTime, color: color),
    );
  }

  Text _dayText({
    required DateTime dayTime,
    required Color color,
  }) {
    final text = "${dayTime.day}";
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontFamily.gmarketSansRegular,
        fontSize: _dayFontSize,
        color: color,
      ),
    );
  }
}

extension on _HomeCalendarState {
  Widget _outsideBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return _dayCell(
      dayTime: day,
      color: Colors.grey,
    );
  }

  Widget _todayBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return _dayCell(
      dayTime: day,
      color: Colors.black,
    );
  }

  Widget _defaultBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return _dayCell(
      dayTime: day,
      color: Colors.black,
    );
  }
}

extension on _HomeCalendarState {
  Widget _selectedBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    final color = EBColors.blue3;
    final dayTime = focusedDay.day != day.day ? day : focusedDay;
    final margin = EdgeInsets.symmetric(horizontal: _dayCellTopPadding);
    final padding = EdgeInsets.only(top: _dayCellTopPadding);
    const alignment = Alignment.topCenter;

    final decoration = ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color, width: _selectDayCellBordorWidth),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(20),
        ),
      ),
    );

    return AnimatedContainer(
      duration: _animateDuration,
      margin: margin,
      padding: padding,
      decoration: decoration,
      alignment: alignment,
      child: _dayText(dayTime: dayTime, color: color),
    );
  }
}

extension on _HomeCalendarState {
  DaysOfWeekStyle get _daysOfWeekStyle {
    final textStyleOfDaysOfWeek = TextStyle(
      color: Colors.grey,
      fontFamily: FontFamily.gmarketSansRegular,
      fontSize: _weekFontSize,
    );

    return DaysOfWeekStyle(
      dowTextFormatter: (date, locale) =>
          DateFormat.E(EBLocale.en_US.name).format(date).toUpperCase(),
      weekdayStyle: textStyleOfDaysOfWeek,
      weekendStyle: textStyleOfDaysOfWeek,
    );
  }
}

// logic
extension on _HomeCalendarState {
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay.value = focusedDay;
      });
    }
  }
}
