part of 'detailroute_view.dart';

class DetailRouteListItem extends StatelessWidget {
  final double inset = 15;
  final double space = 7;
  const DetailRouteListItem({super.key});

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
                    departure(),
                    info(),
                    destination(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text info() {
    return const Text('도보 642');
  }

  Column iconTransport() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.directions_walk),
        Text('약 3분'),
      ],
    );
  }

  Row departure() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('서울특별시 광진구 아차산로 463-4'),
        Spacer(),
        EBRoundedButton(text: '지도보기'),
      ],
    );
  }

  Row destination() {
    return const Row(
      children: [
        Text('서울특별시 광진구 아차산로 463-4까지 걷기'),
      ],
    );
  }
}
