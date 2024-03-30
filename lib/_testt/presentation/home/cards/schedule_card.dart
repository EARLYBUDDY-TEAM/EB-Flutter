import 'package:flutter/material.dart';
import '../../../../shared/assets/EBFont.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

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
                  fontFamily: NanumSquare.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '얼리버디 회의',
                style: TextStyle(
                  fontFamily: GmarketSans.regular,
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
                  fontFamily: NanumSquare.regular,
                  color: Colors.white,
                ),
              ),
              Text(
                '강남역 스터디카페',
                style: TextStyle(
                  fontFamily: NanumSquare.regular,
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
