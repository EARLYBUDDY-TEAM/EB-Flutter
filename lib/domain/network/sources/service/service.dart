import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:earlybuddy/domain/network/sources/endpoint/response/dto.dart';
import 'package:earlybuddy/shared/eb_env/eb_env.dart';
part 'client.dart';
part 'request.dart';
part 'decoder.dart';
part 'result.dart';

final class NetworkService {
  final NetworkClientAB _client;
  final NetworkDecoderAB _decoder;

  static final NetworkService shared = NetworkService();

  NetworkService({
    NetworkClientAB? client,
    NetworkDecoderAB? decoder,
  })  : _client = client ?? NetworkClient(),
        _decoder = decoder ?? JsonDecoder();

  Future<NetworkResult> request<P>(NetworkRequestAB<P> request) async {
    Response response;

    try {
      response = await _client.request(request);
    } on DioException catch (dioException) {
      final statusCode = dioException.response?.statusCode;
      final failure = checkStatusCode(statusCode);
      log('checkechcl');
      return failure;
    }

    if (P == EmptyDTO && response.data == null) {
      var empty = EmptyDTO() as P;
      return Success(
        dto: empty,
        statusCode: response.statusCode,
      );
    }

    if (response.data == null) {
      return Failure(
        error: NetworkError.noResponseData,
        statusCode: response.statusCode,
      );
    }

    try {
      P model = _decoder.decode(response.data!, request.converter);
      return Success(
        dto: model,
        statusCode: response.statusCode,
      );
    } on NetworkError catch (error) {
      return Failure(
        error: error,
        statusCode: response.statusCode,
      );
    }
  }

  Failure checkStatusCode(int? statusCode) {
    if (statusCode == null) {
      return Failure(error: NetworkError.unknown);
    }

    NetworkError error;
    switch (statusCode) {
      case >= 400 && < 500:
        error = NetworkError.clientError;
      case >= 500 && < 600:
        error = NetworkError.serverError;
      default:
        error = NetworkError.unknown;
    }

    return Failure(
      error: error,
      statusCode: statusCode,
    );
  }
}
