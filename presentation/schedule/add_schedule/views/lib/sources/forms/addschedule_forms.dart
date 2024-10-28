part of '../../eb_add_schedule.dart';

final class _AddScheduleForms extends StatelessWidget {
  final double bottomPadding;
  final double fontSize = 17;

  const _AddScheduleForms({
    super.key,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _ScheduleNameForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _TimeForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _NotifyScheduleForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _PlaceForm(fontSize: fontSize),
            const SizedBox(height: 20),
            StartPlaceForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _NotifyTransportForm(fontSize: fontSize),
            SizedBox(height: bottomPadding),
          ],
        ),
      ),
    );
  }
}
