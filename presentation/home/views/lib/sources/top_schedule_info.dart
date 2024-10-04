part of '../eb_home.dart';

final class _TopScheduleInfoView extends StatelessWidget {
  const _TopScheduleInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '다음일정',
                style: TextStyle(
                  fontFamily: FontFamily.nanumSquareBold,
                  color: Colors.white,
                ),
              ),
              Text(
                '얼리버디 회의',
                style: TextStyle(
                  fontFamily: FontFamily.gmarketSansRegular,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '오후 22:00',
                style: TextStyle(
                  fontFamily: FontFamily.nanumSquareRegular,
                  color: Colors.white,
                ),
              ),
              Text(
                '강남역 스터디카페',
                style: TextStyle(
                  fontFamily: FontFamily.nanumSquareRegular,
                  color: Colors.white,
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
