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
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: _dayCellTopPadding),
            child: Text(text, style: _dayTextStyle(color: color)),
          ),
        ],
      ),
    );
  }

  TextStyle _dayTextStyle({
    required Color color,
  }) {
    return TextStyle(
      fontFamily: FontFamily.gmarketSansRegular,
      fontSize: _dayFontSize,
      color: color,
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
      padding: EdgeInsets.symmetric(horizontal: _dayCellTopPadding),
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
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: _dayCellTopPadding),
                child: Text(
                  "${focusedDay.day}",
                  style: _dayTextStyle(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
