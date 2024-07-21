import 'package:dio/dio.dart';
import 'package:earlybuddy/domain/network/sources/network_service/network_service.dart';

final class MockNetworkClient implements NetworkClientAB {
  dynamic responseData;
  int? statusCode;

  MockNetworkClient({
    required this.responseData,
    required this.statusCode,
  });

  @override
  Future<Response> request(NetworkRequestAB request) {
    return Future.delayed(const Duration(seconds: 1), () {
      return Response(
        data: responseData,
        requestOptions: RequestOptions(),
        statusCode: statusCode,
      );
    });
  }
}
