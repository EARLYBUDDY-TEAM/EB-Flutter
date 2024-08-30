part of 'service.dart';

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
