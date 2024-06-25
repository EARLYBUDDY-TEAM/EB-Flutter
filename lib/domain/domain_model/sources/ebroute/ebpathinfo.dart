part of '../domain_model.dart';

final class EBPathInfo extends Equatable {
  final String totalTime;
  final int payment;
  final int transitCount;

  const EBPathInfo({
    required this.totalTime,
    required this.payment,
    required this.transitCount,
  });

  EBPathInfo.fromDTO({required EBPathInfoDTO ebPathInfoDTO})
      : totalTime = _totalTime(ebPathInfoDTO.totalTime),
        payment = ebPathInfoDTO.payment,
        transitCount =
            ebPathInfoDTO.busTransitCount + ebPathInfoDTO.subwayTransitCount;

  @override
  List<Object?> get props => [
        totalTime,
        payment,
        transitCount,
      ];

  static EBPathInfo mock() {
    return EBPathInfo(
      totalTime: _totalTime(12),
      payment: 124142,
      transitCount: 12,
    );
  }
}

String _totalTime(int time) {
  if (time == 0) {
    return '0분';
  }

  final int h = time ~/ 60;
  final String hour = h == 0 ? '' : '$h시간';
  final int m = time % 60;
  final String minute = '$m분';
  return hour == '' ? minute : '$hour $minute';
}
