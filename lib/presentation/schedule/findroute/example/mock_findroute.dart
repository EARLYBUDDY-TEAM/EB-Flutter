part of 'findroute_example.dart';

class _MockFindRoute extends StatelessWidget {
  const _MockFindRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FindRouteView(
        start: Coordi.mockStart(),
        end: Coordi.mockEnd(),
      ),
    );
  }
}
