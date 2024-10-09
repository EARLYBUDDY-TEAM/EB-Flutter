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

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, _) {
            return _HomeCalendarHeader(focusedDay: value);
          },
        ),
        const SizedBox(height: 20),
        TableCalendar(
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
            todayBuilder: _todayBuilder,
            outsideBuilder: _outsideBuilder,
          ),
        ),
      ],
    );
  }

  Widget _dayText({
    required String text,
    required Color color,
  }) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontFamily: FontFamily.gmarketSansRegular,
          fontSize: 13,
          color: color,
        ),
      ),
    );
  }

  Widget _outsideBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return _dayText(
      text: "${day.day}",
      color: Colors.grey,
    );
  }

  Widget _todayBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return _dayText(
      text: "${day.day}",
      color: Colors.black,
    );
  }

  Widget _defaultBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return _dayText(
      text: "${day.day}",
      color: Colors.black,
    );
  }

  Widget _selectedBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    final color = EBColors.blue3;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: DecoratedBox(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: color, width: 1.5),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
                bottom: Radius.circular(20),
              ),
            ),
          ),
          child: _dayText(
            text: "${focusedDay.day}",
            color: color,
          ),
        ),
      ),
    );
  }

  DaysOfWeekStyle get _daysOfWeekStyle {
    const textStyleOfDaysOfWeek = TextStyle(
      color: Colors.grey,
      fontFamily: FontFamily.gmarketSansRegular,
      fontSize: 13,
    );

    return DaysOfWeekStyle(
      dowTextFormatter: (date, locale) =>
          DateFormat.E(EBLocale.en_US.name).format(date).toUpperCase(),
      weekdayStyle: textStyleOfDaysOfWeek,
      weekendStyle: textStyleOfDaysOfWeek,
    );
  }
}

extension on _HomeCalendarState {
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      log("Selected Day : ${selectedDay.toString()}");
      log("Focused Day : ${focusedDay.toString()}");
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay.value = focusedDay;
      });
    }
  }
}
