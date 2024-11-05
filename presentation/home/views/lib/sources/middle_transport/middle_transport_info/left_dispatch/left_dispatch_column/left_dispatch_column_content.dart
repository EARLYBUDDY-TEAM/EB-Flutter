part of '../../../../../eb_home.dart';

final class _LeftDispatchColumnContent extends StatelessWidget {
  final Transport? selectedTransport;
  final EBSubPath transportSubPath;

  const _LeftDispatchColumnContent({
    super.key,
    required this.transportSubPath,
    required this.selectedTransport,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

extension on _LeftDispatchColumnContent {
  String get transportName {
    final transport = selectedTransport;
    if (transport == null) {
      return '-';
    }

    switch (transport) {
      case Subway():
        return transport.type;
      case Bus():
        return transport.number;
    }
  }

  Color get transportColor {
    final transport = selectedTransport;
    if (transport == null) {
      return Colors.grey;
    }

    switch (transport) {
      case Subway():
        return transport.color();
      case Bus():
        return transport.color();
    }
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

extension on _LeftDispatchColumnContent {
  String get stationName {
    return transportSubPath.startName;
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

extension on _LeftDispatchColumnContent {
  String get transportType {
    final type = transportSubPath.type;

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

extension on _LeftDispatchColumnContent {
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
