part of 'service.dart';

sealed class NetworkResult {}

class Success<DTO> extends NetworkResult {
  DTO dto;

  Success(this.dto);
}

class Failure extends NetworkResult {
  int? statusCode;
  NetworkError error;

  Failure({
    required this.error,
    required this.statusCode,
  });
}
