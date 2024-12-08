part of 'service.dart';

sealed class NetworkResponse<M> {}

final class SuccessResponse<M> extends NetworkResponse<M> {
  final int statusCode;
  final M model;

  SuccessResponse({
    required this.statusCode,
    required this.model,
  });

  SuccessResponse<F> copyWith<F>({
    required F model,
    int? statusCode,
  }) {
    return SuccessResponse<F>(
      statusCode: statusCode ?? this.statusCode,
      model: model,
    );
  }
}

final class FailureResponse<M> extends NetworkResponse<M> {
  final int statusCode;
  final NetworkError error;

  FailureResponse({
    required this.statusCode,
    required this.error,
  });

  FailureResponse<F> copyWith<F>({
    int? statusCode,
    NetworkError? error,
  }) {
    return FailureResponse<F>(
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
    );
  }
}
