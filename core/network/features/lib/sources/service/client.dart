part of 'service.dart';

class NetworkClient implements NetworkClientAB {
  late Dio _dio;

  NetworkClient() {
    _dio = Dio();
    final baseUrl = ENV_SERVER.url;
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
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
        _dio.options.headers = null;
        return response;

      case HTTPMethod.post:
        _dio.options.headers = request.headers;
        var response = await _dio.post(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );
        _dio.options.headers = null;
        return response;

      case HTTPMethod.put:
        _dio.options.headers = request.headers;
        var response = await _dio.put(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );
        _dio.options.headers = null;
        return response;
    }
  }
}
