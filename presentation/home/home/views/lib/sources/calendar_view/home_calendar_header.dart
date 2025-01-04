part of '../../eb_home.dart';

final class _HomeCalendarHeader extends StatelessWidget {
  final ValueNotifier<DateTime> focusedDay;

  const _HomeCalendarHeader({
    super.key,
    required this.focusedDay,
  });

  String _headerText(DateTime date) {
    final year = "${date.year}";
    final monthString = date.addZeroToMonth();
    return "$year.$monthString";
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: ValueListenableBuilder(
        valueListenable: focusedDay,
        builder: (context, value, _) {
          final headerText = _headerText(value);
          return _buttonContent(headerText);
        },
      ),
      onPressed: () async {
        final DateTime? selectedDay = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
          initialDate: focusedDay.value,
          locale: const Locale('ko'),
        );

        if (selectedDay != null) {
          focusedDay.value = selectedDay;
          context.read<HomeBloc>().add(
                SetCalendarState(
                  calendarState: CalendarState(selectedDay: selectedDay),
                ),
              );
        }
      },
    );
  }

  Widget _buttonContent(
    String headerText,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          headerText,
          style: const TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
        const Icon(
          Icons.arrow_forward_ios,
          size: 17,
          color: Colors.grey,
        ),
      ],
    );
  }
}
