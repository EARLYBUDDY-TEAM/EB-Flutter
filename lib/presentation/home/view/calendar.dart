part of 'home_view.dart';

class _Calendar extends StatelessWidget {
  final DateTime focusedDay = DateTime.now();
  final DateTime firstDay = DateTime.utc(2020, 01, 01);
  final DateTime lastDay = DateTime.utc(2030, 01, 01);

  _Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,
      locale: 'ko_KR',
    );
  }
}
