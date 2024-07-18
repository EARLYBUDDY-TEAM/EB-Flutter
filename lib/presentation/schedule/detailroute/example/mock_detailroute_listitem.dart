part of 'detailroute_example.dart';

final class _MockDetailRouteListItem extends StatelessWidget {
  const _MockDetailRouteListItem();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DetailRouteListItem.walk(EBSubPath.mockWalk()),
            DetailRouteListItem.other(EBSubPath.mockBus()),
            DetailRouteListItem.other(EBSubPath.mockSubway()),
          ],
        ),
      ),
    );
  }
}
