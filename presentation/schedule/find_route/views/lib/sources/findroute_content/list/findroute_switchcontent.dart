part of '../../../eb_find_route.dart';

final class _FindRouteSwitchContent extends StatelessWidget {
  final double headerHeight = 100;

  const _FindRouteSwitchContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      builder: (context, state) {
        return Expanded(
          child: ScrollWithHeader(
            header: _FindRouteHeaderSortView(
              height: headerHeight,
            ),
            headerHeight: headerHeight,
            list: [
              _switchContent(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _switchContent(
    BuildContext context,
    FindRouteState state,
  ) {
    final ebRoute = state.ebRoute;
    final contentStatus = state.contentStatus;

    if (ebRoute == null) {
      return const SizedBox();
    }

    final lineOfPaths = state.viewState.transportLineOfRoute.lineOfRoute;
    final ebPaths = ebRoute.ebPaths;

    switch (contentStatus) {
      case EmptyDataFindRouteStatus():
        return const EmptyDataView();

      case SelectFindRouteStatus():
        return _SelectRouteListView(
          ebPaths: ebPaths,
          lineOfPaths: lineOfPaths,
        );

      case DetailFindRouteStatus():
        final subPaths = ebPaths[contentStatus.selectedIndex].ebSubPaths;
        return _DetailRouteListView(
          subPaths: subPaths,
        );
    }
  }
}
