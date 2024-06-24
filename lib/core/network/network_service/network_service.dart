import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:earlybuddy/core/network/endpoint/response/dto.dart';
import 'package:earlybuddy/shared/eb_error/eb_error.dart';
part 'network_client.dart';
part 'network_request.dart';
part 'network_decoder.dart';

final class NetworkService {
  final NetworkClientAB _client;
  final NetworkDecoderAB _decoder;

  static final NetworkService shared = NetworkService();

  NetworkService({
    NetworkClientAB? client,
    NetworkDecoderAB? decoder,
  })  : _client = client ?? NetworkClient(),
        _decoder = decoder ?? JsonDecoder();

  Future<P> request<P>(NetworkRequestAB<P> request) async {
    final Response response = await _client.request(request);

    try {
      checkStatusCode(response);
    } catch (error) {
      rethrow;
    }

    if ((response.data == null) && (P == EmptyDTO)) {
      var empty = EmptyDTO() as P;
      return empty;
    }

    try {
      P model = _decoder.decode(response.data!, request.converter);
      return model;
    } catch (error) {
      rethrow;
    }
  }

  void checkStatusCode(Response<dynamic> response) {
    int? statusCode = response.statusCode;
    if (statusCode == null) {
      log('No StatusCode');
      throw NetworkError.noStatusCode;
    }
    if ((200 <= statusCode) && (statusCode < 300)) {
      return;
    } else {
      var message = response.statusMessage;
      log('StatusCode Error : $statusCode, message: $message');
      throw NetworkError.inValidStatusCode;
    }
  }
}
