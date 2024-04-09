part of 'addschedule_view.dart';

class _Forms extends StatelessWidget {
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
            _AlertForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _PlaceForm(fontSize: fontSize),
            const SizedBox(height: 20),
            _RouteForm(fontSize: fontSize),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
