part of '../../../../../eb_find_route.dart';

final class _IconTransport extends StatelessWidget {
  final EBSubPath ebSubPath;

  const _IconTransport({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    final transportList = ebSubPath.transportList;
    final time = ebSubPath.time;
    Widget content = _IconTransportItem.walk(time);

    if (transportList.isNotEmpty) {
      switch (transportList) {
        case List<Subway>():
          final subway = transportList.first;
          content = _IconTransportItem.subway(
            ebSubPath.time,
            subway.color(),
          );
        case List<Bus>():
          final bus = transportList.first;
          content = _IconTransportItem.bus(
            ebSubPath.time,
            bus.color(),
          );
        default:
          break;
      }
    }

    return content;
  }
}

final class _IconTransportItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

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
              fontFamily: FontFamily.nanumSquareRegular,
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

  factory _IconTransportItem.bus(int time, Color color) {
    return _IconTransportItem(
      text: '약 $time분',
      icon: CupertinoIcons.bus,
      color: color,
    );
  }

  factory _IconTransportItem.subway(int time, Color color) {
    return _IconTransportItem(
      text: '약 $time분',
      icon: Icons.subway_outlined,
      color: color,
    );
  }
}
