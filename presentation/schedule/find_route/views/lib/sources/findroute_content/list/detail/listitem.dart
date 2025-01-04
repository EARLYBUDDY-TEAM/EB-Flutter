part of '../../../../eb_find_route.dart';

final class DetailRouteListItem extends StatelessWidget {
  final EBSubPath subPath;
  final SealedFindRouteSetting setting;

  const DetailRouteListItem({
    super.key,
    required this.subPath,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailRouteBloc>(
      create: (context) {
        final realTimeInfoEvent = RealTimeInfoEvent(
          homeRepository: RepositoryProvider.of<HomeRepositoryAB>(context),
        );

        return DetailRouteBloc(
          realTimeInfoEvent: realTimeInfoEvent,
          // );
        )..add(
            SetupDetailRoute(subPath: subPath),
          );
      },
      child: DetailRouteListItemContent(
        setting: setting,
        ebSubPath: subPath,
      ),
    );
  }
}

final class DetailRouteListItemContent extends StatelessWidget {
  final EBSubPath ebSubPath;
  final SealedFindRouteSetting setting;
  final double contentInset = 15;
  final double rowSpace = 8;

  const DetailRouteListItemContent({
    super.key,
    required this.ebSubPath,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (3):
        return _ListItemWalk(
          setting: setting,
          ebSubPath: ebSubPath,
          contentInset: contentInset,
          rowSpace: rowSpace,
        );
      default:
        return _ListItemOther(
          setting: setting,
          ebSubPath: ebSubPath,
          contentInset: contentInset,
          rowSpace: rowSpace,
        );
    }
  }
}
