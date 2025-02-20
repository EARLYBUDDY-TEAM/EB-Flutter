part of '../eb_network_interface.dart';

abstract class NetworkRequestAB<P> {
  String get path;
  HTTPMethod get method;
  Map<String, String>? get headers;
  Map<String, String>? get query;
  Object? get requestData;

  P Function(dynamic responseData)? get converter;
}
