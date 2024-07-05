part of '../domain_model.dart';

// final class EBPathInfo extends Equatable {
//   final String totalTime;
//   final String totalWalkTime;
//   final int payment;
//   final int transitCount;

//   const EBPathInfo({
//     required this.totalTime,
//     required this.totalWalkTime,
//     required this.payment,
//     required this.transitCount,
//   });

//   EBPathInfo.fromDTO({required EBPathInfoDTO ebPathInfoDTO})
//       : totalTime = _timeIntToString(ebPathInfoDTO.totalTime),
//         totalWalkTime = _timeIntToString(ebPathInfoDTO.totalWalkTime),
//         payment = ebPathInfoDTO.payment,
//         transitCount =
//             ebPathInfoDTO.busTransitCount + ebPathInfoDTO.subwayTransitCount;

//   @override
//   List<Object?> get props => [
//         totalTime,
//         totalWalkTime,
//         payment,
//         transitCount,
//       ];

//   static EBPathInfo mock() {
//     return EBPathInfo(
//       totalTime: _timeIntToString(12),
//       totalWalkTime: _timeIntToString(9),
//       payment: 124142,
//       transitCount: 12,
//     );
//   }
// }

String _timeIntToString(int time) {
  if (time <= 0) {
    return '0분';
  }

  final int h = time ~/ 60;
  final String hour = h == 0 ? '' : '$h시간';
  final int m = time % 60;
  final String minute = '$m분';
  return hour == '' ? minute : '$hour $minute';
}
