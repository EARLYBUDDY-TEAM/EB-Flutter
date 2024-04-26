part of 'network_service.dart';

abstract class NetworkClientAB<Q extends NetworkRequestAB> {
  /// [request]를 실행하고, Dio[Response]를 반환한다
  Future<Response> request(Q request) async {
    throw UnimplementedError('구현부');
  }
}

class NetworkClient implements NetworkClientAB {
  late Dio _dio;

  NetworkClient() {
    _dio = Dio();
    _dio.options = BaseOptions(
      baseUrl: 'http://localhost:8000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );
  }

  @override
  Future<Response> request(NetworkRequestAB request) async {
    switch (request.method) {
      case HTTPMethod.get:
        _dio.options.headers = request.headers;
        var response = await _dio.get(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );
        return response;

      case HTTPMethod.post:
        _dio.options.headers = request.headers;
        var response = await _dio.post(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );
        return response;

      case HTTPMethod.put:
        _dio.options.headers = request.headers;
        var response = await _dio.put(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );
        return response;
    }
  }
}
