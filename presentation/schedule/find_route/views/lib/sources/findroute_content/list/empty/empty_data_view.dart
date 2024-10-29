part of '../../../../eb_find_route.dart';

final class FindRouteEmptyDataView extends StatelessWidget {
  final double headerHeight;

  const FindRouteEmptyDataView({
    super.key,
    required this.headerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FindRouteInfoView(),
        _FindRouteHeaderSortView(height: headerHeight),
        const Expanded(
          child: FindRouteEmptyDataContent(),
        ),
      ],
    );
  }
}

final class FindRouteEmptyDataContent extends StatelessWidget {
  final text1 = "대중교통 검색 결과가 없어요.";
  final text2 = "가까운 거리는 도보를 이용해 주세요.";
  final color = Colors.grey;

  const FindRouteEmptyDataContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.exclamationmark_circle,
          color: color,
          size: 50,
        ),
        const SizedBox(height: 10),
        _text(text1),
        _text(text2),
      ],
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
