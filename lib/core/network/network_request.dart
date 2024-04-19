part of 'network_service.dart';

enum HTTPMethod {
  get,
  put;

  @override
  String toString() {
    switch (this) {
      case HTTPMethod.get:
        return 'GET';
      case HTTPMethod.put:
        return 'PUT';
    }
  }
}

abstract class NetworkRequestAB<P> {
  String get path;
  HTTPMethod get method;
  Map<String, String>? get headers;
  Map<String, String>? get query;
  Object? get data;

  P Function(dynamic data) get converter;
}
