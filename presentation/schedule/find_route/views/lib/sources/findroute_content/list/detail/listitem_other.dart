part of '../../../../eb_find_route.dart';

final class _ListItemOther extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double contentInset;
  final double rowSpace;
  final double colSpace = 10;
  final SealedFindRouteSetting setting;

  const _ListItemOther({
    super.key,
    required this.ebSubPath,
    required this.contentInset,
    required this.rowSpace,
    required this.setting,
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
                    Expanded(
                      child: _StartInfo(
                        setting: setting,
                        ebSubPath: ebSubPath,
                      ),
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
    final transportList = ebSubPath.transportList;
    Color lineColor = Colors.grey;

    if (transportList.isNotEmpty) {
      switch (transportList) {
        case List<Subway>():
          final subway = transportList.first;
          lineColor = subway.color();
        case List<Bus>():
          final bus = transportList.first;
          lineColor = bus.color();
        default:
          break;
      }
    }

    return _VTransportLineOther(color: lineColor);
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
