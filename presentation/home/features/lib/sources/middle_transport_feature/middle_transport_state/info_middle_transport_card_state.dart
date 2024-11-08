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
  final EBSubPath subPath;
  final DateTime expectStartTime;
  final int expectTotalMinute;

  const InfoMiddleTransportCardState({
    required this.selectedTransport,
    required this.subPath,
    required this.expectStartTime,
    required this.expectTotalMinute,
  });

  InfoMiddleTransportCardState copyWith({
    Transport? Function()? selectedTransport,
    EBSubPath? subPath,
    DateTime? expectStartTime,
    int? expectTotalTime,
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
        subPath,
        expectStartTime,
        expectTotalMinute,
      ];
}
