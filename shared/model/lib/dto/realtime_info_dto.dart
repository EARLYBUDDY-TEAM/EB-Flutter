part of '../dto.dart';

final class RealTimeInfoDTO {
  final int arrivalSec1;
  final int arrivalSec2;

  RealTimeInfoDTO({
    required this.arrivalSec1,
    required this.arrivalSec2,
  });

  static RealTimeInfoDTO fromJson(Map<String, dynamic> j) {
    return RealTimeInfoDTO(
      arrivalSec1: j['arrivalSec1'],
      arrivalSec2: j['arrivalSec2'],
    );
  }
}
