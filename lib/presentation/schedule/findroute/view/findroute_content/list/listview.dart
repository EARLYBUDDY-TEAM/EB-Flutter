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
        return Column(
          children: [
            InkWell(
              child: FindRouteListItem(
                ebPath: ebPaths[index],
                lineOfPath: lineOfPaths[index],
              ),
              onTap: () {
                log(ebPaths[index].payment.toString());
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
            ),
          ],
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
