part of '../../../../../../../eb_home.dart';

final class _LeftDispatchColumnContent extends StatelessWidget {
  final Transport? selectedTransport;
  final EBSubPath transportSubPath;
  final int expectTotalMinute;

  const _LeftDispatchColumnContent({
    super.key,
    required this.transportSubPath,
    required this.selectedTransport,
    required this.expectTotalMinute,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _transportStationName(),
        _transportTypeText(),
        const SizedBox(height: 10),
        _expectArrivalText(),
      ],
    );
  }
}

extension on _LeftDispatchColumnContent {
  Widget _transportStationName() {
    return Row(
      children: [
        _transportNameContainer(),
        const SizedBox(width: 8),
        _stationNameText(),
      ],
    );
  }

  String get _transportName {
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

  Color get _transportColor {
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
        color: _transportColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          _transportName,
          style: const TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  String get _stationName {
    return transportSubPath.startName;
  }

  Widget _stationNameText() {
    return Text(
      _stationName,
      style: const TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: Colors.black87,
        fontSize: 13,
      ),
    );
  }
}

extension on _LeftDispatchColumnContent {
  String get _transportType {
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
      '$_transportType 도착까지',
      style: const TextStyle(
        fontFamily: FontFamily.gmarketSansBold,
        fontSize: 18,
      ),
    );
  }
}

extension on _LeftDispatchColumnContent {
  String get _expectArrivalString {
    final expectArrivalTime =
        DateTime.now().add(Duration(minutes: expectTotalMinute));
    return "${expectArrivalTime.addZeroToHour()}:${expectArrivalTime.addZeroToMinute()}";
  }

  Widget _expectArrivalText() {
    const double fontSize = 13;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '약속장소에 ',
          style: TextStyle(
            fontFamily: FontFamily.gmarketSansRegular,
            color: Colors.black87,
            fontSize: fontSize,
          ),
        ),
        Row(
          children: [
            Text(
              _expectArrivalString,
              style: const TextStyle(
                fontFamily: FontFamily.gmarketSansBold,
                color: Colors.blue,
                fontSize: fontSize,
              ),
            ),
            const Text(
              ' 도착 예정',
              style: TextStyle(
                fontFamily: FontFamily.gmarketSansRegular,
                color: Colors.black87,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
