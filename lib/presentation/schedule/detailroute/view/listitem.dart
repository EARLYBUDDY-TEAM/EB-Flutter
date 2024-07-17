part of 'detailroute_view.dart';

final class DetailRouteListItem extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double inset = 15;
  final double space = 7;

  const DetailRouteListItem({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        color: Colors.amber.shade200,
        child: Padding(
          padding: EdgeInsets.only(left: inset, right: inset, bottom: inset),
          child: Row(
            children: [
              iconTransport(),
              SizedBox(width: space),
              Padding(
                padding: EdgeInsets.only(top: inset),
                child: VDashLine(color: Colors.grey.shade700),
              ),
              SizedBox(width: space),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    startInfo(),
                    info(),
                    endInfo(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on DetailRouteListItem {
  Column iconTransport() {
    final text = '약 ${ebSubPath.time}분';
    Color? color;
    IconData icon;
    switch (ebSubPath.type) {
      case (1):
        icon = Icons.subway_outlined;
        color = ebSubPath.transports[0].subway?.color();
      case (2):
        icon = CupertinoIcons.bus;
        color = ebSubPath.transports[0].bus?.color();
      default:
        icon = Icons.directions_walk;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(text),
      ],
    );
  }
}

extension on DetailRouteListItem {
  Row startInfo() {
    final text = ebSubPath.startName;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(text),
        const Spacer(),
        const EBRoundedButton(text: '지도보기'),
      ],
    );
  }
}

extension on DetailRouteListItem {
  Text info() {
    return const Text('도보 642');
  }
}

extension on DetailRouteListItem {
  Row endInfo() {
    var text = ebSubPath.endName;
    if (ebSubPath.type == 3) {
      text += '까지 걷기';
    }
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: NanumSquare.regular,
            fontSize: 18,
            color: EBColors.text,
          ),
        ),
      ],
    );
  }
}
