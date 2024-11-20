part of '../../../../eb_find_route.dart';

final class DetailRouteListItem extends StatelessWidget {
  final EBSubPath subPath;

  const DetailRouteListItem({
    super.key,
    required this.subPath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailRouteBloc>(
      create: (context) {
        return DetailRouteBloc(
          realTimeInfoEvent: RepositoryProvider.of<RealTimeInfoEvent>(context),
        )..add(
            SetupDetailRoute(subPath: subPath),
          );
      },
      child: DetailRouteListItemContent(
        ebSubPath: subPath,
      ),
    );
  }
}

final class DetailRouteListItemContent extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double contentInset = 15;
  final double rowSpace = 8;

  const DetailRouteListItemContent({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (3):
        return _ListItemWalk(
          ebSubPath: ebSubPath,
          contentInset: contentInset,
          rowSpace: rowSpace,
        );
      default:
        return _ListItemOther(
          ebSubPath: ebSubPath,
          contentInset: contentInset,
          rowSpace: rowSpace,
        );
    }
  }
}
