part of '../../eb_uikit.dart';

final class TransportPopupMenuItemContent extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color color;
  final ArrivalInfo? arrivalInfo1;
  final ArrivalInfo? arrivalInfo2;

  const TransportPopupMenuItemContent({
    super.key,
    required this.icon,
    required this.name,
    required this.color,
    required this.arrivalInfo1,
    required this.arrivalInfo2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _transportName(),
          const SizedBox(height: 4),
          _arrivalInfoText(),
        ],
      ),
    );
  }

  factory TransportPopupMenuItemContent.bus({
    required Bus bus,
    required RealTimeInfo? realTimeInfo,
  }) {
    return TransportPopupMenuItemContent(
      icon: CupertinoIcons.bus,
      name: bus.number,
      color: bus.color(),
      arrivalInfo1: realTimeInfo?.arrivalInfo1,
      arrivalInfo2: realTimeInfo?.arrivalInfo2,
    );
  }

  factory TransportPopupMenuItemContent.subway({
    required Subway subway,
    required RealTimeInfo? realTimeInfo,
  }) {
    return TransportPopupMenuItemContent(
      icon: Icons.subway_outlined,
      name: subway.type,
      color: subway.color(),
      arrivalInfo1: realTimeInfo?.arrivalInfo1,
      arrivalInfo2: realTimeInfo?.arrivalInfo2,
    );
  }
}

extension on TransportPopupMenuItemContent {
  Widget _transportName() {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          name,
          style: const TextStyle(
            fontFamily: FontFamily.gmarketSansBold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

extension on TransportPopupMenuItemContent {
  String _arrivalInfoString({
    required int? arrivalSec,
    required int? leftStation,
  }) {
    final tmpTime =
        (arrivalSec == null) ? "-분" : EBTime.intSecToString(arrivalSec);
    final time = (tmpTime == '0분') ? '곧 도착' : tmpTime;
    final station = (leftStation == null) ? "(-정류장)" : "($leftStation정류장)";
    return time + station;
  }

  Widget _arrivalInfoText() {
    final arrival1 = _arrivalInfoString(
      arrivalSec: arrivalInfo1?.arrivalSec,
      leftStation: arrivalInfo1?.leftStation,
    );

    final arrival2 = _arrivalInfoString(
      arrivalSec: arrivalInfo2?.arrivalSec,
      leftStation: arrivalInfo2?.leftStation,
    );
    final text = "$arrival1, $arrival2";

    return Text(
      text,
      style: const TextStyle(
        color: Colors.red,
      ),
    );
  }
}
