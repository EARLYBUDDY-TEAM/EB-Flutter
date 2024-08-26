part of 'detailroute_example.dart';

final class _MockDetailrouteListview extends StatelessWidget {
  final List<EBSubPath> subPaths = [
    EBSubPath.mockWalk(),
    EBSubPath.mockSubway(),
    EBSubPath.mockWalk(),
    EBSubPath.mockBus(),
    EBSubPath.mockWalk(),
    EBSubPath.mockSubway(),
  ];

  _MockDetailrouteListview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: subPaths.length,
        itemBuilder: (context, index) {
          return DetailRouteListItem(ebSubPath: subPaths[index]);
        },
      ),
    );
  }
}
