part of 'service.dart';

sealed class NetworkResult {}

final class Success<MODEL> extends NetworkResult {
  final int statusCode;
  final MODEL model;

  Success({
    required this.model,
    int? statusCode,
  }) : statusCode = statusCode ?? 200;
}

final class Failure extends NetworkResult {
  final int statusCode;
  final NetworkError error;

  Failure({required this.error, int? statusCode})
      : statusCode = statusCode ?? -1;
}
