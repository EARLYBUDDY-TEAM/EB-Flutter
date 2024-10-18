part of '../../eb_add_schedule.dart';

class _AddScheduleForms extends StatelessWidget {
  final double fontSize = 17;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _NameForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _TimeForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _NotifyForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _PlaceForm(fontSize: fontSize),
            const SizedBox(height: 20),
            StartPlaceForm(fontSize: fontSize),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
