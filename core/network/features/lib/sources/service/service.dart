import 'package:dio/dio.dart';
import 'package:eb_model/dto.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_env/eb_env.dart';
import 'package:eb_network_interface/network_ab.dart';

part 'client.dart';
part 'request.dart';
part 'decoder.dart';
part 'response.dart';

final class NetworkService {
  final NetworkClientAB _client;
  final NetworkDecoderAB _decoder;

  static final NetworkService shared = NetworkService();

  NetworkService({
    NetworkClientAB? client,
    NetworkDecoderAB? decoder,
  })  : _client = client ?? NetworkClient(),
        _decoder = decoder ?? JsonDecoder();

  Future<Result> request<P>(NetworkRequestAB<P> request) async {
    Response response;

    try {
      response = await _client.request(request);
    } on DioException catch (dioException) {
      final statusCode = dioException.response?.statusCode;
      final failure = checkStatusCode(statusCode);
      return failure;
    }

    if (P == EmptyDTO && response.data == null) {
      var empty = EmptyDTO() as P;
      return Success(
        success: SuccessResponse(
          statusCode: response.statusCode ?? 200,
          model: empty,
        ),
      );
    }

    if (response.data == null) {
      return Failure(
        failure: FailureResponse(
          error: NetworkError.noResponseData,
          statusCode: response.statusCode ?? 599,
        ),
      );
    }

    try {
      P model = _decoder.decode(response.data!, request.converter);
      return Success(
        success: SuccessResponse(
          model: model,
          statusCode: response.statusCode ?? 200,
        ),
      );
    } on NetworkError catch (error) {
      return Failure(
        failure: FailureResponse(
          error: error,
          statusCode: response.statusCode ?? 499,
        ),
      );
    }
  }

  Failure checkStatusCode(int? statusCode) {
    var error = NetworkError.unknown;
    if (statusCode != null) {
      switch (statusCode) {
        case >= 400 && < 500:
          error = NetworkError.clientError;
        case >= 500 && < 600:
          error = NetworkError.serverError;
        default:
          error = NetworkError.unknown;
      }
    }

    final response = FailureResponse(
      statusCode: statusCode ?? 100,
      error: error,
    );

    return Failure(failure: response);
  }
}
