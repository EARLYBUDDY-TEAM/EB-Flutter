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
        ),
      ],
    );
  }

  DaysOfWeekStyle get _daysOfWeekStyle {
    return DaysOfWeekStyle(
      dowTextFormatter: (date, locale) =>
          DateFormat.E(EBLocale.en_US.name).format(date).toUpperCase(),
    );
  }

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
