part of '../../detailroute_view.dart';

final class DetailRouteListItem extends StatelessWidget {
  final Widget content;
  static const double inset = 15;
  static const double space = 7;

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
      content: _DetailRouteListItemWalk(
        ebSubPath: ebSubPath,
        inset: inset,
        space: space,
      ),
    );
  }

  factory DetailRouteListItem.other(EBSubPath ebSubPath) {
    return DetailRouteListItem(
      content: _DetailRouteListItemOther(
        ebSubPath: ebSubPath,
        inset: inset,
        space: space,
      ),
    );
  }
}

final class _DetailRouteListItemOther extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double inset;
  final double space;

  const _DetailRouteListItemOther({
    super.key,
    required this.ebSubPath,
    required this.inset,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      color: Colors.amber.shade200,
      child: Padding(
        padding: EdgeInsets.all(inset),
        child: Center(
          child: Row(
            children: [
              _IconTransport(ebSubPath: ebSubPath),
              SizedBox(width: space),
              VDashLine(color: Colors.grey.shade700),
              SizedBox(width: space),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StartInfo(ebSubPath: ebSubPath),
                    _LaneInfo(ebSubPath: ebSubPath),
                    _EndInfo(ebSubPath: ebSubPath),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _DetailRouteListItemWalk extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double inset;
  final double space;

  const _DetailRouteListItemWalk({
    super.key,
    required this.ebSubPath,
    required this.inset,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      color: Colors.amber.shade200,
      child: Padding(
        padding: EdgeInsets.all(inset),
        child: Center(
          child: Row(
            children: [
              _IconTransport(ebSubPath: ebSubPath),
              SizedBox(width: space),
              VDashLine(color: Colors.grey.shade700),
              SizedBox(width: space),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StartInfo(ebSubPath: ebSubPath),
                    _LaneInfo(ebSubPath: ebSubPath),
                    _EndInfo(ebSubPath: ebSubPath),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
