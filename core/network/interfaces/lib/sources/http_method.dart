part of '../network_ab.dart';

enum HTTPMethod {
  get,
  post,
  put,
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
      case HTTPMethod.delete:
        return 'DELETE';
    }
  }
}
