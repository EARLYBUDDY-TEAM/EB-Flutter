import 'package:dio/dio.dart';
import 'package:eb_network_interface/network_ab.dart';

final class MockSuccessNetworkClient implements NetworkClientAB {
  dynamic responseData;

  MockSuccessNetworkClient({required this.responseData});

  @override
  Future<Response> request(NetworkRequestAB request) {
    return Future.delayed(const Duration(seconds: 1), () {
      return Response(
        data: responseData,
        requestOptions: RequestOptions(),
        statusCode: 200,
      );
    });
  }
}

final class MockFailNetworkClient implements NetworkClientAB {
  dynamic responseData;
  int? statusCode;

  MockFailNetworkClient({
    required this.responseData,
    required this.statusCode,
  });

  @override
  Future<Response> request(NetworkRequestAB request) {
    return Future.delayed(const Duration(seconds: 1), () {
      final response = Response(
        requestOptions: RequestOptions(),
        statusCode: statusCode,
      );
      throw DioException(
        requestOptions: RequestOptions(),
        response: response,
      );
    });
  }
}
