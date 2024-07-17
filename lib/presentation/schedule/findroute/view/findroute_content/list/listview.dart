part of '../../findroute_view.dart';

class _FindRouteListView extends StatelessWidget {
  final double headerHeight = 100;

  const _FindRouteListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      builder: (context, findRouteState) {
        final ebRoute = findRouteState.ebRoute;
        if (ebRoute == null) {
          return const Center(
            child: Text('Empty Route...'),
          );
        } else {
          final ebPaths = ebRoute.ebPaths;
          final lineOfPaths =
              findRouteState.viewState.transportLineOfRoute.lineOfRoute;
          return Expanded(
            child: ScrollWithHeader(
              header: _FindRouteSortView(height: headerHeight),
              headerHeight: headerHeight,
              list: _list(ebPaths, lineOfPaths),
            ),
          );
        }
      },
    );
  }

  List<Widget> _list(
      List<EBPath> ebPaths, List<TransportLineOfPath> lineOfPaths) {
    var list = [
      for (var i = 0; i <= ebPaths.length; i++)
        i != ebPaths.length
            ? FindRouteListItem(
                ebPath: ebPaths[i],
                lineOfPath: lineOfPaths[i],
                isLast: false,
              )
            : FindRouteListItem(
                ebPath: ebPaths[i - 1],
                lineOfPath: lineOfPaths[i - 1],
                isLast: true,
              )
    ];

    return list;
  }
}
