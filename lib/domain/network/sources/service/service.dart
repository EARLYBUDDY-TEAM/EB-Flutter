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
      if (dioException.response != null) {
        final statusCode = dioException.response?.statusCode;

        if (statusCode == null) {
          return Failure(error: NetworkError.unknown, statusCode: null);
        } else {
          final failure = checkStatusCode(statusCode);
          return failure;
        }
      } else {
        return Failure(error: NetworkError.unknown, statusCode: null);
      }
    }

    if ((response.data == null) && (P == EmptyDTO)) {
      var empty = EmptyDTO() as P;
      return Success(empty);
    }

    try {
      P model = _decoder.decode(response.data!, request.converter);
      return Success(model);
    } on NetworkError catch (error) {
      return Failure(
        error: error,
        statusCode: response.statusCode ?? 200,
      );
    }
  }

  Failure checkStatusCode(int statusCode) {
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
