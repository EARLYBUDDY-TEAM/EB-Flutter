part of 'service.dart';

enum HTTPMethod {
  get,
  post,
  put;

  @override
  String toString() {
    switch (this) {
      case HTTPMethod.get:
        return 'GET';
      case HTTPMethod.put:
        return 'PUT';
      case HTTPMethod.post:
        return 'POST';
    }
  }
}

abstract class NetworkRequestAB<P> {
  String get path;
  HTTPMethod get method;
  Map<String, String>? get headers;
  Map<String, String>? get query;
  Object? get requestData;

  P Function(dynamic responseData)? get converter;
}

class ApiRequest<P> implements NetworkRequestAB<P> {
  @override
  String path;
  @override
  HTTPMethod method;
  @override
  Map<String, String>? headers;
  @override
  Map<String, String>? query;
  @override
  Object? requestData;

  @override
  P Function(dynamic responseData)? converter;

  ApiRequest({
    required this.path,
    required this.method,
    this.converter,
    this.headers,
    this.query,
    this.requestData,
  });
}
