part of '../../findroute_view.dart';

class _FindRouteListView extends StatelessWidget {
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
          final lineOfRoute =
              findRouteState.viewState.transportLineOfRoute.lineOfRoute;
          return Expanded(
            child: ScrollWithHeader(
              length: ebPaths.length,
              header: const _FindRouteSortView(),
              item: (index) => FindRouteListItem(
                ebPath: ebPaths[index],
                lineOfPath: lineOfRoute[index],
              ),
            ),
          );
        }
      },
    );
  }
}
