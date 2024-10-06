part of '../../eb_home.dart';

final class _TopScheduleInfoView extends StatelessWidget {
  final textColor = Colors.white;

  const _TopScheduleInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '다음일정',
                style: TextStyle(
                  fontFamily: FontFamily.nanumSquareBold,
                  color: textColor,
                ),
              ),
              Text(
                '얼리버디 회의',
                style: TextStyle(
                  fontFamily: FontFamily.gmarketSansRegular,
                  fontSize: 18,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '오후 22:00',
                style: TextStyle(
                  fontFamily: FontFamily.nanumSquareRegular,
                  color: textColor,
                ),
              ),
              Text(
                '강남역 스터디카페',
                style: TextStyle(
                  fontFamily: FontFamily.nanumSquareRegular,
                  color: textColor,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   width: double.infinity,
          //   height: 1,
          // ),
        ],
      ),
    );
  }
}
