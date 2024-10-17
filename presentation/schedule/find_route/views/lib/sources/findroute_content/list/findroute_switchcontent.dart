part of '../../../eb_find_route.dart';

final class _FindRouteSwitchContent extends StatelessWidget {
  final double headerHeight = 100;

  const _FindRouteSwitchContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      builder: (context, findRouteState) {
        final ebRoute = findRouteState.ebRoute;
        final contentStatus = findRouteState.contentStatus;

        if (ebRoute == null) {
          return const SizedBox();
        }

        final lineOfPaths =
            findRouteState.viewState.transportLineOfRoute.lineOfRoute;

        switch (contentStatus) {
          case EmptyDataFindRouteStatus():
            return const SizedBox();

          case SelectFindRouteStatus():
            return _selectRouteListView(
              ebRoute: ebRoute,
              lineOfPaths: lineOfPaths,
            );

          case DetailFindRouteStatus():
            final subPaths = contentStatus.subPaths;
            return _DetailRouteListView(
              subPaths: subPaths,
            );
        }
      },
    );
  }

  Widget _selectRouteListView({
    required EBRoute ebRoute,
    required List<TransportLineOfPath> lineOfPaths,
  }) {
    final ebPaths = ebRoute.ebPaths;
    return Expanded(
      child: ScrollWithHeader(
        header: _FindRouteHeaderSortView(
          height: headerHeight,
        ),
        headerHeight: headerHeight,
        list: [
          SelectRouteListView(
            ebPaths: ebPaths,
            lineOfPaths: lineOfPaths,
          ),
        ],
      ),
    );
  }
}
