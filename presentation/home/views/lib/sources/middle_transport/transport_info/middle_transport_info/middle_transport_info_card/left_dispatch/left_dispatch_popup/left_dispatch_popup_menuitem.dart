part of '../../../../../../../eb_home.dart';

final class _LeftDisPatchPopupMenuItemContent extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color color;
  final int arrivalSec1;
  final int leftStation1;
  final int arrivalSec2;
  final int leftStation2;

  const _LeftDisPatchPopupMenuItemContent({
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

  factory _LeftDisPatchPopupMenuItemContent.bus({
    required String name,
    required Color color,
    required int arrivalSec1,
    required int arrivalSec2,
    required int leftStation1,
    required int leftStation2,
  }) {
    const icon = CupertinoIcons.bus;
    return _LeftDisPatchPopupMenuItemContent(
      icon: icon,
      name: name,
      color: color,
      arrivalSec1: arrivalSec1,
      arrivalSec2: arrivalSec2,
      leftStation1: leftStation1,
      leftStation2: leftStation2,
    );
  }

  factory _LeftDisPatchPopupMenuItemContent.subway({
    required String name,
    required Color color,
    required int arrivalSec1,
    required int arrivalSec2,
    required int leftStation1,
    required int leftStation2,
  }) {
    const icon = Icons.subway_outlined;
    return _LeftDisPatchPopupMenuItemContent(
      icon: icon,
      name: name,
      color: color,
      arrivalSec1: arrivalSec1,
      arrivalSec2: arrivalSec2,
      leftStation1: leftStation1,
      leftStation2: leftStation2,
    );
  }
}

extension on _LeftDisPatchPopupMenuItemContent {
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

extension on _LeftDisPatchPopupMenuItemContent {
  String _arrivalInfoString({
    required int arrivalSec,
    required int leftStation,
  }) {
    final tmpTime = EBTime.intSecToString(arrivalSec);
    final time = (tmpTime == '0분') ? '곧 도착' : tmpTime;
    final station = "($leftStation정류장)";
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
