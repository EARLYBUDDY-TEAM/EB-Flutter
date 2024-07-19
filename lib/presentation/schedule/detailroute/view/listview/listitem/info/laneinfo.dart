part of '../../../detailroute_view.dart';

final class _LaneInfo extends StatelessWidget {
  final EBSubPath ebSubPath;

  const _LaneInfo({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (1):
        return _LaneInfoItem.subway();
      case (2):
        return _LaneInfoItem.bus();
      default:
        return _LaneInfoItem.walk(ebSubPath.distance);
    }
  }
}

final class _LaneInfoItem extends StatelessWidget {
  final Widget laneInfo;

  const _LaneInfoItem({
    super.key,
    required this.laneInfo,
  });

  @override
  Widget build(BuildContext context) {
    return laneInfo;
  }

  factory _LaneInfoItem.walk(int distance) {
    return _LaneInfoItem(
        laneInfo: Text(
      '도보 ${distance}m',
      style: const TextStyle(
        fontFamily: NanumSquare.regular,
        fontSize: 15,
        color: Colors.black54,
      ),
    ));
  }

  factory _LaneInfoItem.bus() {
    const String text =
        'busbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsubusbusbsu';
    return const _LaneInfoItem(laneInfo: Text(text));
  }

  factory _LaneInfoItem.subway() {
    return const _LaneInfoItem(laneInfo: Text('subwayy'));
  }
}
