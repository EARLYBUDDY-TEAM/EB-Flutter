part of '../../eb_uikit.dart';

final class TransportPopupMenuItemContent extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color color;
  final int? arrivalSec1;
  final int? leftStation1;
  final int? arrivalSec2;
  final int? leftStation2;

  const TransportPopupMenuItemContent({
    super.key,
    required this.icon,
    required this.name,
    required this.color,
    required this.arrivalSec1,
    required this.arrivalSec2,
    required this.leftStation1,
    required this.leftStation2,
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
      arrivalSec1: realTimeInfo?.arrivalSec1,
      arrivalSec2: realTimeInfo?.arrivalSec2,
      leftStation1: realTimeInfo?.leftStation1,
      leftStation2: realTimeInfo?.leftStation2,
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
      arrivalSec1: realTimeInfo?.arrivalSec1,
      arrivalSec2: realTimeInfo?.arrivalSec2,
      leftStation1: realTimeInfo?.leftStation1,
      leftStation2: realTimeInfo?.leftStation2,
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
      arrivalSec: arrivalSec1,
      leftStation: leftStation1,
    );

    final arrival2 = _arrivalInfoString(
      arrivalSec: arrivalSec2,
      leftStation: leftStation2,
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