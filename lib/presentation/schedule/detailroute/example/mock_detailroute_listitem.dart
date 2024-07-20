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
            DetailRouteListItem(ebSubPath: EBSubPath.mockWalk()),
            DetailRouteListItem(ebSubPath: EBSubPath.mockBus()),
            DetailRouteListItem(ebSubPath: EBSubPath.mockSubway()),
          ],
        ),
      ),
    );
  }
}
