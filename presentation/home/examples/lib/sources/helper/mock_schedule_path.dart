part of '../home_example.dart';

List<SchedulePath> mockSchedulePath() {
  // final List<SchedulePath> mockSchedulePathList = [];
  // final today = DateTime.now().add(const Duration(minutes: 10));
  // final yesterday = today.add(const Duration(days: -1));
  // final nextDay = today.add(const Duration(days: 1));

  // for (int i = 1; i < 20; i++) {
  //   final tmpDay = today.add(Duration(days: i));
  //   final tmpSchedule = i % 2 == 0
  //       ? ScheduleCard.mock(time: tmpDay)
  //       : ScheduleCard.mockwithPlace(time: tmpDay);
  //   mockScheduleList.add(tmpSchedule);
  // }

  // for (int i = 1; i < 10; i++) {
  //   mockScheduleList.add(ScheduleCard.mockwithPlace(time: today));
  //   mockScheduleList.add(ScheduleCard.mockwithPlace(time: nextDay));
  // }

  // return mockScheduleList;

  // for (int i = 1; i < 10; i++) {
  //   mockSchedulePathList.add(
  //     SchedulePath(
  //       schedule: Schedule.mock(time: yesterday),
  //     ),
  //   );

  //   mockSchedulePathList.add(
  //     SchedulePath(
  //       schedule: Schedule.mock(time: today),
  //     ),
  //   );

  //   mockSchedulePathList.add(
  //     SchedulePath(
  //       schedule: Schedule.mock(time: nextDay),
  //     ),
  //   );
  // }

  final today = DateTime.now().add(const Duration(hours: 2));

  final schedule = Schedule.mock(time: today);
  // final tmpEBPath = EBPath.mockDongToGwang();
  // final tmpSubPath = EBSubPath.mockDongToGwang();
  final tmpEBPath = EBPath.mockGasanToSuwon();
  final tmpSubPath = EBSubPath.mockGasanToSuwon();
  final ebSubPathList = [
    tmpSubPath,
    tmpSubPath,
    tmpSubPath,
    tmpSubPath,
  ];
  final ebPath = tmpEBPath.copyWith(
    ebSubPathList: ebSubPathList,
  );
  final schedulePath = SchedulePath(
    schedule: schedule,
    ebPath: ebPath,
  );

  return [schedulePath];
}
