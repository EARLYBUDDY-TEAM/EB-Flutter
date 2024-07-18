part of '../../detailroute_view.dart';

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
        height: 150,
        color: Colors.amber.shade200,
        child: Padding(
          padding: EdgeInsets.all(inset),
          child: Row(
            children: [
              _IconTransport(ebSubPath: ebSubPath),
              SizedBox(width: space),
              VDashLine(color: Colors.grey.shade700),
              SizedBox(width: space),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StartInfo(ebSubPath: ebSubPath),
                    info(),
                    _EndInfo(ebSubPath: ebSubPath),
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
  Text info() {
    return const Text('도보 642');
  }
}
