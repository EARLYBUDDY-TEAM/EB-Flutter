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
        return _LaneInfoItemOther();
      case (2):
        return _LaneInfoItemOther();
      default:
        return _LaneInfoItemWalk(distance: ebSubPath.distance);
    }
  }
}

final class _LaneInfoItemOther extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}

final class _LaneInfoItemWalk extends StatelessWidget {
  final int distance;

  const _LaneInfoItemWalk({
    super.key,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '도보 ${distance}m',
      style: const TextStyle(
        fontFamily: NanumSquare.regular,
        fontSize: 15,
        color: Colors.black54,
      ),
    );
  }
}
