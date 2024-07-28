part of 'service.dart';

sealed class NetworkResult {}

final class Success<DTO> extends NetworkResult {
  final int statusCode;
  final DTO dto;

  Success({
    required this.dto,
    int? statusCode,
  }) : statusCode = statusCode ?? 200;
}

final class Failure extends NetworkResult {
  final int statusCode;
  final NetworkError error;

  Failure({required this.error, int? statusCode})
      : statusCode = statusCode ?? -1;
}
