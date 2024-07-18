part of '../../../detailroute_view.dart';

final class _IconTransport extends StatelessWidget {
  final EBSubPath ebSubPath;

  const _IconTransport({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (1):
        return _IconTransportItem.subway(
          ebSubPath.time,
          ebSubPath.transports[0].subway?.color(),
        );
      case (2):
        return _IconTransportItem.bus(
          ebSubPath.time,
          ebSubPath.transports[0].bus?.color(),
        );
      default:
        return _IconTransportItem.walk(ebSubPath.time);
    }
  }
}

final class _IconTransportItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;

  const _IconTransportItem({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              fontFamily: NanumSquare.regular,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  factory _IconTransportItem.walk(int time) {
    return _IconTransportItem(
      text: '약 $time분',
      icon: Icons.directions_walk,
      color: EBColors.text,
    );
  }

  factory _IconTransportItem.bus(int time, Color? color) {
    return _IconTransportItem(
      text: '약 $time분',
      icon: CupertinoIcons.bus,
      color: color,
    );
  }

  factory _IconTransportItem.subway(int time, Color? color) {
    return _IconTransportItem(
      text: '약 $time분',
      icon: Icons.subway_outlined,
      color: color,
    );
  }
}
