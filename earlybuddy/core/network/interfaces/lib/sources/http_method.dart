part of '../network_ab.dart';

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
