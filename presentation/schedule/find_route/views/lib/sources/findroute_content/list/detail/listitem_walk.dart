part of '../../../../eb_find_route.dart';

final class _ListItemWalk extends StatelessWidget {
  final EBSubPath ebSubPath;
  final double contentInset;
  final double rowSpace;

  const _ListItemWalk({
    super.key,
    required this.ebSubPath,
    required this.contentInset,
    required this.rowSpace,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Padding(
        padding: EdgeInsets.all(contentInset),
        child: Center(
          child: Row(
            children: [
              _IconTransport(ebSubPath: ebSubPath),
              SizedBox(width: rowSpace),
              VDashLine(color: Colors.grey.shade700),
              SizedBox(width: rowSpace),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StartInfo(ebSubPath: ebSubPath),
                    _LaneInfo(ebSubPath: ebSubPath),
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
