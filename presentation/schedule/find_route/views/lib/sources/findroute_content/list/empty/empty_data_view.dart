part of '../../../../eb_find_route.dart';

final class _FindRouteEmptyDataView extends StatelessWidget {
  final double headerHeight;

  const _FindRouteEmptyDataView({
    super.key,
    required this.headerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _FindRouteInfoView(),
          _FindRouteHeaderSortView(height: headerHeight),
          const _FindRouteEmptyDataContent(),
        ],
      ),
    );
  }
}

final class _FindRouteEmptyDataContent extends StatelessWidget {
  final text1 = "대중교통 검색 결과가 없어요.";
  final text2 = "가까운 거리는 도보를 이용해 주세요.";
  final color = Colors.grey;

  const _FindRouteEmptyDataContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Icon(
            CupertinoIcons.exclamationmark_circle,
            color: color,
            size: 50,
          ),
          const SizedBox(height: 10),
          _text(text1),
          _text(text2),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontFamily.nanumSquareRegular,
        color: color,
        fontSize: 20,
      ),
    );
  }
}
