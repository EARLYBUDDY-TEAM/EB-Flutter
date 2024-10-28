part of '../eb_network_interface.dart';

enum HTTPMethod {
  get,
  post,
  put,
  patch,
  delete;

  @override
  String toString() {
    switch (this) {
      case HTTPMethod.get:
        return 'GET';
      case HTTPMethod.put:
        return 'PUT';
      case HTTPMethod.post:
        return 'POST';
      case HTTPMethod.patch:
        return 'PATCH';
      case HTTPMethod.delete:
        return 'DELETE';
    }
  }
}
