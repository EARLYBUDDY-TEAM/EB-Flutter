part of '../../eb_home.dart';

final class _HomeCalendarHeader extends StatelessWidget {
  final DateTime focusedDay;

  const _HomeCalendarHeader({
    super.key,
    required this.focusedDay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: _HomeCalendarHeaderStateful(
        focusedDay: focusedDay,
      ),
    );
  }
}

final class _HomeCalendarHeaderStateful extends StatefulWidget {
  final DateTime focusedDay;

  const _HomeCalendarHeaderStateful({
    super.key,
    required this.focusedDay,
  });

  @override
  State<StatefulWidget> createState() => _HomeCalendarHeaderState();
}

final class _HomeCalendarHeaderState
    extends State<_HomeCalendarHeaderStateful> {
  late DateTime headerDay = widget.focusedDay;

  String get _headerText {
    final year = "${headerDay.year}";
    final monthString = headerDay.addZeroToMonth();
    return "$year.$monthString";
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _buttonContent(),
      onPressed: () async {
        final DateTime? selectedDay = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
          initialDate: headerDay,
          locale: const Locale('ko'),
        );

        setState(() {
          if (selectedDay != null) {
            headerDay = selectedDay;
          }
        });
      },
    );
  }

  Widget _buttonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _headerText,
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
