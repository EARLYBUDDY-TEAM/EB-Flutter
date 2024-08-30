part of '../network_ab.dart';

abstract class NetworkClientAB<Q extends NetworkRequestAB> {
  /// [request]를 실행하고, Dio[Response]를 반환한다
  Future<Response> request(Q request) async {
    throw UnimplementedError('구현부');
  }
}
