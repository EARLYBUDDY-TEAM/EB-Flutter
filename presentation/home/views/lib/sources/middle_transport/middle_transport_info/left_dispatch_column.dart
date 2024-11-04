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

  const _LeftDispatchColumn({
    super.key,
    required this.subPath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          log("cehckckckck");
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _transportNameContainer(),
                const SizedBox(width: 8),
                _stationNameText(),
              ],
            ),
            _transportTypeText(),
            const SizedBox(height: 10),
            _expectArrivalText(),
          ],
        ),
      ),
    );
  }
}

extension on _LeftDispatchColumn {
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

  Widget _transportNameContainer() {
    return Container(
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
    );
  }
}

extension on _LeftDispatchColumn {
  String get stationName {
    return subPath.startName;
  }

  Widget _stationNameText() {
    return Text(
      stationName,
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.black87,
        fontSize: 13,
      ),
    );
  }
}

extension on _LeftDispatchColumn {
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

  Widget _transportTypeText() {
    return Text(
      '$transportType 도착까지',
      style: const TextStyle(
        fontFamily: FontFamily.gmarketSansBold,
        fontSize: 18,
      ),
    );
  }
}

extension on _LeftDispatchColumn {
  Widget _expectArrivalText() {
    const double fontSize = 13;

    return const Row(
      children: [
        Text(
          '약속장소에 ',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansRegular,
            color: Colors.black87,
            fontSize: fontSize,
          ),
        ),
        Text(
          '14:20',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            color: Colors.blue,
            fontSize: fontSize,
          ),
        ),
        Text(
          ' 도착 예정',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansRegular,
            color: Colors.black87,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
