part of 'service.dart';

final class SuccessResponse<M> {
  final int statusCode;
  final M model;

  SuccessResponse({
    required this.statusCode,
    required this.model,
  });
}

final class FailureResponse {
  final int statusCode;
  final NetworkError error;

  FailureResponse({
    required this.statusCode,
    required this.error,
  });
}
