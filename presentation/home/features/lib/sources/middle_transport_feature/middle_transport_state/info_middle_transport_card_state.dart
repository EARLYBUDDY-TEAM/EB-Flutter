part of '../../../middle_transport_feature.dart';

/* 
카드 바뀌는 기준
-> expectStartTime

약속장소에 도착 예정
-> 현재 subpath 기준 목적지 까지 걸리는 시간 추가
-> expectTotalTime
*/

final class InfoMiddleTransportCardState extends Equatable {
  final Transport? selectedTransport;
  final DateTime expectStartTime;
  final int expectTotalMinute;
  final EBSubPath subPath;

  const InfoMiddleTransportCardState({
    required this.selectedTransport,
    required this.expectStartTime,
    required this.expectTotalMinute,
    required this.subPath,
  });

  InfoMiddleTransportCardState copyWith({
    Transport? Function()? selectedTransport,
    DateTime? expectStartTime,
    int? expectTotalTime,
    EBSubPath? subPath,
  }) {
    return InfoMiddleTransportCardState(
      selectedTransport: selectedTransport != null
          ? selectedTransport()
          : this.selectedTransport,
      subPath: subPath ?? this.subPath,
      expectStartTime: expectStartTime ?? this.expectStartTime,
      expectTotalMinute: expectTotalTime ?? expectTotalMinute,
    );
  }

  @override
  List<Object?> get props => [
        selectedTransport,
        expectStartTime,
        expectStartTime,
        subPath,
      ];
}

// sealed class SealedInfoMiddleTransportCardState extends Equatable {
//   final DateTime expectStartTime;
//   final int expectTotalMinute;
//   final EBSubPath subPath;

//   const SealedInfoMiddleTransportCardState({
//     required this.expectStartTime,
//     required this.expectTotalMinute,
//     required this.subPath,
//   });
// }

// final class SubwayMiddleTransportCardState
//     extends SealedInfoMiddleTransportCardState {

//   const SubwayMiddleTransportCardState({
//     required super.expectStartTime,
//     required super.expectTotalMinute,
//   });

//   @override
//   List<Object?> get props => [];
// }

// final class BusMiddleTransportCardState
//     extends SealedInfoMiddleTransportCardState {
//   final Bus? selectedTransport;
//   final EBSubPath<Bus> subPath;

//   const BusMiddleTransportCardState({
//     required super.expectStartTime,
//     required super.expectTotalMinute,
//     required EBSubPath<Bus> subPath,
//     required Bus? selectedTransport,
//   })  : subPath = subPath,
//         selectedTransport = selectedTransport;

//   BusMiddleTransportCardState copyWith({
//     Bus? Function()? selectedTransport,
//     EBSubPath<Bus>? subPath,
//     DateTime? expectStartTime,
//     int? expectTotalTime,
//   }) {
//     return BusMiddleTransportCardState(
//       selectedTransport: selectedTransport != null
//           ? selectedTransport()
//           : this.selectedTransport,
//       subPath: subPath ?? this.subPath,
//       expectStartTime: expectStartTime ?? this.expectStartTime,
//       expectTotalMinute: expectTotalTime ?? expectTotalMinute,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         selectedTransport,
//         subPath,
//         expectStartTime,
//         expectTotalMinute,
//       ];
// }
