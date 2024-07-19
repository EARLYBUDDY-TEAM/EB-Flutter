part of '../../detailroute_view.dart';

final class _ListItemOther extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double contentInset;
  final double rowSpace;
  final double colSpace = 20;

  const _ListItemOther({
    super.key,
    required this.ebSubPath,
    required this.contentInset,
    required this.rowSpace,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(contentInset),
          child: Row(
            children: [
              _IconTransport(ebSubPath: ebSubPath),
              SizedBox(width: rowSpace),
              _VTransportLine(ebSubPath: ebSubPath),
              SizedBox(width: rowSpace),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StartInfo(
                      ebSubPath: ebSubPath,
                      showMapAction: () {},
                    ),
                    SizedBox(height: colSpace),
                    _LaneInfo(ebSubPath: ebSubPath),
                    SizedBox(height: colSpace),
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

final class _VTransportLine extends StatelessWidget {
  final EBSubPath ebSubPath;

  const _VTransportLine({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (1):
        final color = ebSubPath.transports[0].subway?.color() ?? Colors.grey;
        return _VTransportLineOther(color: color);
      default:
        final color = ebSubPath.transports[0].bus?.color() ?? Colors.grey;
        return _VTransportLineOther(color: color);
    }
  }
}

final class _VTransportLineOther extends StatelessWidget {
  final Color color;
  final double pointSize = 12;

  const _VTransportLineOther({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _point(),
        Expanded(child: _line()),
        _point(),
      ],
    );
  }

  Widget _line() {
    return Container(
      width: 3,
      color: color,
    );
  }

  Widget _point() {
    return Container(
      width: pointSize,
      height: pointSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
