import 'dart:convert';

import 'package:earlybuddy/domain/network/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/network_service/network_service.dart';
import 'package:earlybuddy/shared/eb_error/eb_error.dart';
import 'package:test/test.dart';
import 'endpoint/request/mock_api.dart';
import 'endpoint/response/mock_dto.dart';
import 'network_service/mock_network_client.dart';

void main() {
  group('Network Service Test : StatusCode', () {
    test('Fail test throw noStatusCode', () async {
      var responseData = MockDTO.successJsonData();
      var client = MockNetworkClient(
        responseData: responseData,
        statusCode: null,
      );
      var decoder = JsonDecoder();
      var service = NetworkService(
        client: client,
        decoder: decoder,
      );
      var request = MockAPI.mockDTORequest();

      try {
        MockDTO _ = await service.request(request);
      } catch (e) {
        final error = e as NetworkError;
        expect(error, NetworkError.noStatusCode);
        return;
      }
      throw ('test fail');
    });

    test('Fail test throw inValidStatusCode', () async {
      var responseData = MockDTO.successJsonData();
      var client = MockNetworkClient(
        responseData: responseData,
        statusCode: 300,
      );
      var decoder = JsonDecoder();
      var service = NetworkService(
        client: client,
        decoder: decoder,
      );
      var request = MockAPI.mockDTORequest();

      try {
        MockDTO _ = await service.request(request);
      } catch (e) {
        final error = e as NetworkError;
        expect(error, NetworkError.inValidStatusCode);
        return;
      }
      throw ('test fail');
    });
  });

  group('Network Service Test : Decoder', () {
    test('Success test return MockDTO', () async {
      var responseData = MockDTO.successJsonData();
      Map<String, dynamic> jsonData = jsonDecode(responseData);
      var client = MockNetworkClient(
        responseData: jsonData,
        statusCode: 200,
      );
      var decoder = JsonDecoder();
      var service = NetworkService(
        client: client,
        decoder: decoder,
      );
      var request = MockAPI.mockDTORequest();

      try {
        MockDTO dto = await service.request(request);
        expect(dto.id, 1);
      } catch (e) {
        rethrow;
      }
    });

    test('Fail test throw noConverter', () async {
      var responseData = MockDTO.successJsonData();
      Map<String, dynamic> jsonData = jsonDecode(responseData);
      var client = MockNetworkClient(
        responseData: jsonData,
        statusCode: 200,
      );
      var decoder = JsonDecoder();
      var service = NetworkService(
        client: client,
        decoder: decoder,
      );
      var request = MockAPI.mockDTORequestNoConverter();

      try {
        MockDTO _ = await service.request(request);
      } catch (e) {
        final error = e as NetworkError;
        expect(error, NetworkError.noConverter);
        return;
      }
      throw ('test fail');
    });

    test('Fail test throw jsondEcode', () async {
      var responseData = MockDTO.failJsonData();
      var client = MockNetworkClient(
        responseData: responseData,
        statusCode: 200,
      );
      var decoder = JsonDecoder();
      var service = NetworkService(
        client: client,
        decoder: decoder,
      );
      var request = MockAPI.mockDTORequest();

      try {
        MockDTO _ = await service.request(request);
      } catch (e) {
        final error = e as NetworkError;
        expect(error, NetworkError.jsonDecode);
        return;
      }
      throw ('test fail');
    });
  });

  group('Network Service Test : Success return EmptyDTO', () {
    test('Success test return EmptyDTO', () async {
      var client = MockNetworkClient(
        responseData: null,
        statusCode: 200,
      );
      var service = NetworkService(client: client);
      var request = MockAPI.emptyDTORequest();

      try {
        EmptyDTO _ = await service.request(request);
        return;
      } catch (e) {
        rethrow;
      }
    });
  });
}
