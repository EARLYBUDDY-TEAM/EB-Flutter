part of '../../../../eb_find_route.dart';

final class DetailRouteListItem extends StatelessWidget {
  final EBSubPath ebSubPath;

  const DetailRouteListItem({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailRouteBloc>(
      create: (context) {
        final selectedTransport = ebSubPath.transportList.firstOrNull;

        return DetailRouteBloc(selectedTransport: selectedTransport);
      },
      child: DetailRouteListItemContent(
        ebSubPath: ebSubPath,
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
