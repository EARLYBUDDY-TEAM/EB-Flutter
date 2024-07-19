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
              _VTransportLine.byType(ebSubPath),
              SizedBox(width: rowSpace),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StartInfo(ebSubPath: ebSubPath),
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

class _VTransportLine extends StatelessWidget {
  final Color color;
  final double pointSize = 12;

  const _VTransportLine({
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

  factory _VTransportLine.byType(EBSubPath ebSubPath) {
    switch (ebSubPath.type) {
      case (1):
        return _VTransportLine.subway(ebSubPath);
      default:
        return _VTransportLine.bus(ebSubPath);
    }
  }

  factory _VTransportLine.bus(EBSubPath ebSubPath) {
    final color = ebSubPath.transports[0].bus?.color() ?? Colors.grey;
    return _VTransportLine(color: color);
  }

  factory _VTransportLine.subway(EBSubPath ebSubPath) {
    final color = ebSubPath.transports[0].subway?.color() ?? Colors.grey;
    return _VTransportLine(color: color);
  }
}
