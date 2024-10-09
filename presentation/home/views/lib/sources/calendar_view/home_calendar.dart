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
            }),
        TableCalendar(
          focusedDay: _focusedDay.value,
          firstDay: _firstDay,
          lastDay: _lastDay,
          locale: 'ko_KR',
          onDaySelected: _onDaySelected,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        ),
      ],
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

final class _HomeCalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final double fontSize = 23;

  String get _headerText {
    final year = "${focusedDay.year}";
    final month = (1 <= (focusedDay.month / 10))
        ? "${focusedDay.month}"
        : "0${focusedDay.month}";
    return "$year.$month";
  }

  const _HomeCalendarHeader({
    super.key,
    required this.focusedDay,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _headerText,
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: fontSize,
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: fontSize,
        ),
      ],
    );
  }
}
