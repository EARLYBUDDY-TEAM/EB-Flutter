part of 'selectroute_example.dart';

final class _MockSelectRouteListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _MockListItem(),
        ),
      ),
    );
  }
}

final class _MockListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.amber.shade200,
      child: const SelectRouteListItem(),
    );
  }
}
