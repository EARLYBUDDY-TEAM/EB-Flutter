part of 'findroute_example.dart';

final class _MockFindRouteListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _MockListItem(),
      ),
    );
  }
}

final class _MockListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FindRouteListItem(
      ebPath: EBPath.mock(),
      lineOfPath: TransportLineOfPath.mock(),
    );
  }
}
