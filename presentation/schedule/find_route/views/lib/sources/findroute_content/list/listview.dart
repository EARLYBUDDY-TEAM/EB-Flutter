part of '../../../eb_find_route.dart';

class _FindRouteListView extends StatelessWidget {
  final double headerHeight = 100;

  const _FindRouteListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      builder: (context, findRouteState) {
        final ebRoute = findRouteState.ebRoute;
        final status = findRouteState.status;
        if (status == FindRouteStatus.nodata && ebRoute == null) {
          return const Center(
            child: Text('Empty Route...'),
          );
        } else {
          final ebPaths = ebRoute!.ebPaths;
          final lineOfPaths =
              findRouteState.viewState.transportLineOfRoute.lineOfRoute;
          return Expanded(
            child: ScrollWithHeader(
              header: _FindRouteSortView(
                height: headerHeight,
              ),
              headerHeight: headerHeight,
              list: [
                _FindRouteList(
                  ebPaths: ebPaths,
                  lineOfPaths: lineOfPaths,
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class _DetailRouteList extends StatelessWidget {
  final List<EBSubPath> subPaths;

  const _DetailRouteList({
    super.key,
    required this.subPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _list(context),
    );
  }

  List<Widget> _list(BuildContext context) {
    return List.generate(subPaths.length + 1, (index) {
      if (index != subPaths.length) {
        return Column(
          children: [
            InkWell(
              child: DetailRouteListItem(ebSubPath: subPaths[index]),
              onTap: () {
                BlocProvider.of<FindRouteBloc>(context).add(
                  const setFindRouteStatus(
                    status: FindRouteStatus.selectRoute,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
            _ListDivider(),
          ],
        );
      } else {
        return _OdsayImage();
      }
    });
  }
}

class _FindRouteList extends StatelessWidget {
  final List<EBPath> ebPaths;
  final List<TransportLineOfPath> lineOfPaths;

  const _FindRouteList({
    super.key,
    required this.ebPaths,
    required this.lineOfPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (child) => Column(
          children: _list(context, child),
        ),
      ),
    );
  }

  List<Widget> _list(BuildContext parent, BuildContext child) {
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
                BlocProvider.of<FindRouteBloc>(parent).add(
                    const setFindRouteStatus(
                        status: FindRouteStatus.detailRoute));
                Navigator.push(
                  child,
                  MaterialPageRoute(
                    builder: (child) => _DetailRouteList(
                      subPaths: ebPaths[index].ebSubPaths,
                    ),
                  ),
                );
              },
            ),
            _ListDivider(),
          ],
        );
      } else {
        return _OdsayImage();
      }
    });
  }
}

class _OdsayImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Assets.images.odsay.image(
          height: 40,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

class _ListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        color: Colors.grey.withOpacity(0.5),
        height: 1,
      ),
    );
  }
}
