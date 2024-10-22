part of '../../../eb_find_route.dart';

final class _FindRouteScrollView extends StatelessWidget {
  final double headerHeight;

  const _FindRouteScrollView({
    super.key,
    required this.headerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      buildWhen: (previous, current) {
        return previous.contentStatus != current.contentStatus;
      },
      builder: (context, state) {
        final contentStatus = state.contentStatus;

        return Expanded(
          child: PopScope(
            canPop: (contentStatus is SelectFindRouteStatus) ? true : false,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(
                context: context,
                details: details,
              ),
              child: Column(
                children: [
                  _FindRouteInfoView(),
                  Expanded(
                    child: ScrollWithHeader(
                      header: _FindRouteHeaderSortView(height: headerHeight),
                      headerHeight: headerHeight,
                      list: [
                        _FindRouteScrollSwitchContent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onHorizontalDragUpdate({
    required BuildContext context,
    required DragUpdateDetails details,
  }) {
    const int sensitivity = 40;
    if (details.delta.dx > sensitivity) {
      context.read<FindRouteBloc>().add(
            SetFindRouteContentStatus(
              contentStatus: SelectFindRouteStatus(),
            ),
          );
    }
  }
}

final class _FindRouteScrollSwitchContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindRouteBloc, FindRouteState>(
      buildWhen: (previous, current) {
        return previous.contentStatus != current.contentStatus;
      },
      builder: (context, state) {
        final ebRoute = state.ebRoute;
        if (ebRoute == null) {
          return const _FindRouteEmptyDataContent();
        }

        final contentStatus = state.contentStatus;
        final lineOfPaths = state.viewState.transportLineOfRoute.lineOfRoute;
        final ebPaths = ebRoute.ebPaths;

        switch (contentStatus) {
          case EmptyDataFindRouteStatus():
            return const _FindRouteEmptyDataContent();

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
      },
    );
  }
}
