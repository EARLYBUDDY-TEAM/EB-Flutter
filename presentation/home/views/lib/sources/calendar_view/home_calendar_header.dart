part of '../../eb_home.dart';

final class _HomeCalendarHeader extends StatelessWidget {
  final DateTime focusedDay;

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
          style: const TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 23,
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
