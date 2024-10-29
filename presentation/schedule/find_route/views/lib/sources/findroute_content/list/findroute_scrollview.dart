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
        final flag1 = previous.contentStatus != current.contentStatus;
        final flag2 = previous.routeInfo != current.routeInfo;
        return (flag1 || flag2);
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
      final contentStatus =
          context.read<FindRouteBloc>().state.createSelectContentStatus();

      context.read<FindRouteBloc>().add(
            SetFindRouteContentStatus(
              contentStatus: contentStatus,
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
        final flag1 = previous.contentStatus != current.contentStatus;
        final flag2 = previous.routeInfo != current.routeInfo;

        return (flag1 || flag2);
      },
      builder: (context, state) {
        if (state.routeInfo.ebRoute.ebPaths.isEmpty) {
          return const FindRouteEmptyDataContent();
        }

        final contentStatus = state.contentStatus;

        switch (contentStatus) {
          case EmptyDataFindRouteStatus():
            return const FindRouteEmptyDataContent();

          case SelectFindRouteStatus():
            return _SelectRouteListView(
              ebPaths: contentStatus.ebPaths,
              lineOfPaths: contentStatus.lineOfPaths,
            );

          case DetailFindRouteStatus():
            return _DetailRouteListView(
              subPaths: contentStatus.subPaths,
            );
        }
      },
    );
  }
}
