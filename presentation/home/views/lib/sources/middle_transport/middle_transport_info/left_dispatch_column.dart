part of '../../../eb_home.dart';

final class _LeftDispatchColumn extends StatelessWidget {
  final EBSubPath subPath;

  Color get transportColor {
    if (subPath.type == 1) {
      final subway = subPath.transports.first.subway;
      if (subway != null) {
        return subway.color();
      }
    }

    if (subPath.type == 2) {
      final bus = subPath.transports.first.bus;
      if (bus != null) {
        return bus.color();
      }
    }

    return Colors.grey;
  }

  String get transportName {
    if (subPath.type == 1) {
      final subway = subPath.transports.first.subway;
      if (subway != null) {
        return subway.type;
      }
    }

    if (subPath.type == 2) {
      final bus = subPath.transports.first.bus;
      if (bus != null) {
        return bus.number;
      }
    }

    return '-';
  }

  String get stationName {
    return subPath.startName;
  }

  String get transportType {
    final type = subPath.type;

    switch (type) {
      case 1:
        return "지하철";
      case 2:
        return "버스";
      default:
        return "-";
    }
  }

  const _LeftDispatchColumn({
    super.key,
    required this.subPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: transportColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  transportName,
                  style: const TextStyle(
                    fontFamily: FontFamily.nanumSquareBold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              stationName,
              style: const TextStyle(
                fontFamily: FontFamily.nanumSquareRegular,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
          ],
        ),
        Text(
          '$transportType 도착까지',
          style: const TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              '약속장소에 ',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansRegular,
                color: Colors.black87,
              ),
            ),
            Text(
              '14:20',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansBold,
                color: Colors.blue,
              ),
            ),
            Text(
              ' 도착 예정',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansRegular,
                color: Colors.black87,
              ),
            ),
          ],
        )
      ],
    );
  }
}
