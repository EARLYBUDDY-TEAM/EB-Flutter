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
        final flag3 = previous.setting != current.setting;
        return (flag1 || flag2 || flag3);
      },
      builder: (context, state) {
        final contentStatus = state.contentStatus;
        final setting = state.setting;

        return PopScope(
          canPop: (contentStatus is SelectFindRouteStatus) ? true : false,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(
              context: context,
              details: details,
              setting: setting,
            ),
            child: Column(
              children: [
                _FindRouteInfoView(),
                Expanded(
                  child: FindRouteScrollWithHeader(
                    headerHeight: headerHeight,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onHorizontalDragUpdate({
    required BuildContext context,
    required DragUpdateDetails details,
    required SealedFindRouteSetting setting,
  }) {
    if (setting is ReadFindRouteSetting) {
      return;
    }

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

final class FindRouteScrollWithHeader extends StatelessWidget {
  final double headerHeight;

  const FindRouteScrollWithHeader({
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

        switch (contentStatus) {
          case EmptyDataFindRouteStatus():
            return _EmptyFindRouteScrollWithHeader(
              headerHeight: headerHeight,
            );

          case SelectFindRouteStatus():
            return _ExistFindRouteScrollWithHeader(
              headerHeight: headerHeight,
              scrollContent: _SelectRouteListView(
                ebPaths: contentStatus.ebPaths,
                lineOfPaths: contentStatus.lineOfPaths,
              ),
            );

          case DetailFindRouteStatus():
            return _ExistFindRouteScrollWithHeader(
              headerHeight: headerHeight,
              scrollContent: _DetailRouteListView(
                subPaths: contentStatus.path.ebSubPaths,
              ),
            );
        }
      },
    );
  }
}

final class _EmptyFindRouteScrollWithHeader extends StatelessWidget {
  final double headerHeight;

  const _EmptyFindRouteScrollWithHeader({
    super.key,
    required this.headerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollWithHeader(
      header: _FindRouteHeaderSortView(height: headerHeight),
      headerHeight: headerHeight,
      list: const [],
      defaultContent: const FindRouteEmptyDataContent(),
    );
  }
}

final class _ExistFindRouteScrollWithHeader extends StatelessWidget {
  final Widget scrollContent;
  final double headerHeight;

  const _ExistFindRouteScrollWithHeader({
    super.key,
    required this.scrollContent,
    required this.headerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollWithHeader(
      header: _FindRouteHeaderSortView(height: headerHeight),
      headerHeight: headerHeight,
      list: [
        scrollContent,
      ],
    );
  }
}
