part of '../../eb_home.dart';

final class HomeCalendar extends StatelessWidget {
  const HomeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [EBBoxShadow.init()]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: _HomeCalendarContent(),
        ),
      ),
    );
  }
}

final class _HomeCalendarContent extends StatelessWidget {
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return previous.daySchedule != current.daySchedule;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HomeCalendarHeader(focusedDay: _focusedDay),
            _HomeCalendarBlocStateful(
              daySchedule: state.daySchedule,
              focusedDay: _focusedDay,
            ),
          ],
        );
      },
    );
  }
}

final class _HomeCalendarBlocStateful extends StatelessWidget {
  final ValueNotifier<DateTime> focusedDay;
  final DaySchedule daySchedule;

  const _HomeCalendarBlocStateful({
    super.key,
    required this.focusedDay,
    required this.daySchedule,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return previous.calendarState != current.calendarState;
      },
      builder: (context, state) {
        final initialDate = state.calendarState.selectedDay;
        return _HomeCalendarStateful(
          initialDate: initialDate,
          daySchedule: daySchedule,
          focusedDay: focusedDay,
        );
      },
    );
  }
}

final class _HomeCalendarStateful extends StatefulWidget {
  final DateTime initialDate;
  final DaySchedule daySchedule;
  final ValueNotifier<DateTime> focusedDay;

  const _HomeCalendarStateful({
    super.key,
    required this.initialDate,
    required this.daySchedule,
    required this.focusedDay,
  });

  @override
  State<StatefulWidget> createState() => _HomeCalendarState();
}

final class _HomeCalendarState extends State<_HomeCalendarStateful> {
  DateTime? _selectedDay;

  final DateTime _firstDay = DateTime.utc(2020, 01, 01);
  final DateTime _lastDay = DateTime.utc(2030, 01, 01);

  final double _dayFontSize = 15;
  final double _weekFontSize = 13;
  final double _dayCellPadding = 10;
  final double _selectDayCellBordorWidth = 1.5;
  final _animateDuration = const Duration(milliseconds: 250);
  final _dayCellColor = EBColors.blue3;

  void _setSelectDay() {
    _selectedDay = widget.initialDate;
  }

  @override
  void didUpdateWidget(covariant _HomeCalendarStateful oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialDate != widget.initialDate) {
      _setSelectDay();
    }
  }

  @override
  void initState() {
    super.initState();
    _setSelectDay();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 60,
      daysOfWeekHeight: 40,
      headerVisible: false,
      daysOfWeekStyle: _daysOfWeekStyle,
      focusedDay: widget.focusedDay.value,
      firstDay: _firstDay,
      lastDay: _lastDay,
      locale: EBLocale.ko_KR.name,
      onDaySelected: (
        DateTime selectedDay,
        DateTime focusedDay,
      ) {
        _onDaySelected(selectedDay, focusedDay, context);
      },
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      calendarBuilders: CalendarBuilders(
        selectedBuilder: _selectedBuilder,
        defaultBuilder: _defaultBuilder,
        todayBuilder: _todayBuilder,
        outsideBuilder: _outsideBuilder,
        markerBuilder: _markerBuilder,
      ),
      onPageChanged: (focusedDay) {
        widget.focusedDay.value = focusedDay;
      },
    );
  }
}

// ui
extension on _HomeCalendarState {
  Widget _dayCell({
    required DateTime dayTime,
    required Color textColor,
  }) {
    final padding =
        EdgeInsets.only(top: _dayCellPadding + _selectDayCellBordorWidth);
    const alignment = Alignment.topCenter;
    final margin = EdgeInsets.only(
      left: _dayCellPadding,
      right: _dayCellPadding,
      bottom: _dayCellPadding * 2,
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
      child: _dayText(dayTime: dayTime, color: textColor),
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
      textColor: Colors.grey,
    );
  }

  Widget _todayBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return _dayCell(
      dayTime: day,
      textColor: Colors.black,
    );
  }

  Widget _defaultBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return _dayCell(
      dayTime: day,
      textColor: Colors.black,
    );
  }
}

extension on _HomeCalendarState {
  Widget _selectedBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    final dayTime = focusedDay.day != day.day ? day : focusedDay;
    final margin = EdgeInsets.symmetric(horizontal: _dayCellPadding);
    final padding = EdgeInsets.only(top: _dayCellPadding);
    const alignment = Alignment.topCenter;

    final decoration = ShapeDecoration(
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: _dayCellColor, width: _selectDayCellBordorWidth),
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
      child: _dayText(dayTime: dayTime, color: _dayCellColor),
    );
  }
}

extension on _HomeCalendarState {
  Widget? _markerBuilder(
    BuildContext context,
    DateTime dateTime,
    List<dynamic> events,
  ) {
    final isExistSchedule =
        widget.daySchedule.isExistSchedule(dateTime: dateTime);

    if (isExistSchedule) {
      return Padding(
        padding: EdgeInsets.only(bottom: _dayCellPadding),
        child: Icon(
          Icons.circle,
          size: 6,
          color: _dayCellColor,
        ),
      );
    } else {
      return null;
    }
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
  void _onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
    BuildContext context,
  ) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        widget.focusedDay.value = focusedDay;
      });

      context.read<HomeBloc>().add(
            SetCalendarState(
              calendarState: CalendarState(selectedDay: selectedDay),
            ),
          );
    }
  }
}
