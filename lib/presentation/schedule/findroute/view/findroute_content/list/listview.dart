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
    List<EBPath> ebPaths,
    List<TransportLineOfPath> lineOfPaths,
  ) {
    return List.generate(ebPaths.length + 1, (index) {
      if (index != ebPaths.length) {
        return FindRouteListItem(
          ebPath: ebPaths[index],
          lineOfPath: lineOfPaths[index],
        );
      } else {
        return _odsayImage();
      }
    });
  }

  Widget _odsayImage() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          height: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: EBImages.odsay,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
