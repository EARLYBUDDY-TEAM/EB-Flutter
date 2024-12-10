part of 'service.dart';

class NetworkClient implements NetworkClientAB {
  late Dio _dio;

  NetworkClient() {
    _dio = Dio();
    final baseUrl = ENV_SERVER.url;
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
  }

  @override
  Future<Response> request(NetworkRequestAB request) async {
    _dio.options.headers = request.headers;
    Response response;

    switch (request.method) {
      case HTTPMethod.get:
        response = await _dio.get(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );

      case HTTPMethod.post:
        response = await _dio.post(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );

      case HTTPMethod.put:
        response = await _dio.put(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );

      case HTTPMethod.delete:
        response = await _dio.delete(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );

      case HTTPMethod.patch:
        response = await _dio.patch(
          request.path,
          queryParameters: request.query,
          data: request.requestData,
        );
    }

    _dio.options.headers = null;
    return response;
  }
}
