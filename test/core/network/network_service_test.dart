import 'package:dio/dio.dart';
import 'package:earlybuddy/core/network/network_service/network_service.dart';
import 'package:test/test.dart';

import 'request/mock_api.dart';
import 'response/test_model.dart';

void main() {
  test('test networkservice', () async {
    var responseData = TestModel.jsonData();
    var client = MockNetworkClient(responseData: responseData);
    var decoder = JsonDecoder();
    var service = NetworkService(
      client: client,
      decoder: decoder,
    );
    var request = MockAPI.mockRequest();

    TestModel model = await service.request(request);
    expect(model.id, 1);
  });
}

final class MockNetworkClient implements NetworkClientAB {
  dynamic responseData;

  MockNetworkClient({required this.responseData});

  @override
  Future<Response> request(NetworkRequestAB request) {
    return Future.delayed(const Duration(seconds: 1), () {
      return Response(data: responseData, requestOptions: RequestOptions());
    });
  }
}
