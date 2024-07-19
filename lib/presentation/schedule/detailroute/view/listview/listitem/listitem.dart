part of '../../detailroute_view.dart';

final class DetailRouteListItem extends StatelessWidget {
  final Widget content;
  static const double contentInset = 15;
  static const double rowSpace = 8;

  const DetailRouteListItem({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return content;
  }

  factory DetailRouteListItem.walk(EBSubPath ebSubPath) {
    return DetailRouteListItem(
      content: _ListItemWalk(
        ebSubPath: ebSubPath,
        contentInset: contentInset,
        rowSpace: rowSpace,
      ),
    );
  }

  factory DetailRouteListItem.other(EBSubPath ebSubPath) {
    return DetailRouteListItem(
      content: _ListItemOther(
        ebSubPath: ebSubPath,
        contentInset: contentInset,
        rowSpace: rowSpace,
      ),
    );
  }
}