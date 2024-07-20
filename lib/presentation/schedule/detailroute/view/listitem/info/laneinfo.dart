part of '../../detailroute_view.dart';

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
        return _LaneInfoOther.subway(ebSubPath.stations);
      case (2):
        return _LaneInfoOther.bus(ebSubPath.stations);
      default:
        return _LaneInfoWalk(distance: ebSubPath.distance);
    }
  }
}

final class _LaneInfoOther extends StatefulWidget {
  final List<Station> stations;
  final double spacing = 10;

  const _LaneInfoOther({
    super.key,
    required this.stations,
  });

  factory _LaneInfoOther.bus(List<Station> stations) {
    return _LaneInfoOther(stations: stations);
  }

  factory _LaneInfoOther.subway(List<Station> stations) {
    return _LaneInfoOther(stations: stations);
  }

  @override
  State<StatefulWidget> createState() => _LaneInfoOtherState();
}

final class _LaneInfoOtherState extends State<_LaneInfoOther> {
  bool isShowStationList = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.spacing),
        toggleButton(),
        SizedBox(height: widget.spacing),
        ExpandedSection(
          expand: isShowStationList,
          child: stationList(),
        ),
      ],
    );
  }

  Widget toggleButton() {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.stations.length}개 정류장',
            style: TextStyle(
              fontFamily: NanumSquare.regular,
              color: EBColors.text,
            ),
          ),
          Icon(
            isShowStationList
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_up,
          )
        ],
      ),
      onPressed: () {
        setState(() {
          isShowStationList = !isShowStationList;
        });
      },
    );
  }

  Widget textStation(Station station) {
    return Text(station.name);
  }

  Widget stationList() {
    List<Widget> children = [];

    for (var i = 0; i < widget.stations.length; i++) {
      children.add(textStation(widget.stations[i]));
      children.add(SizedBox(height: widget.spacing));
    }

    return Column(children: children);
  }
}

final class _LaneInfoWalk extends StatelessWidget {
  final int distance;

  const _LaneInfoWalk({
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
