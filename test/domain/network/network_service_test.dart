import 'dart:convert';
import 'package:earlybuddy/core/network/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/service/service.dart';
import 'package:earlybuddy/shared/eb_error/eb_error.dart';
import 'package:earlybuddy/shared/eb_uikit/eb_sources.dart';
import 'package:test/test.dart';
import 'endpoint/request/mock_api.dart';
import 'endpoint/response/mock_dto.dart';
import 'network_service/mock_network_client.dart';

void main() {
  group('Success Network Request', () {
    test('Return MockDTO', () async {
      var responseData = MockDTO.successJsonData();
      Map<String, dynamic> jsonData = jsonDecode(responseData);
      var client = MockSuccessNetworkClient(responseData: jsonData);
      var decoder = JsonDecoder();
      var service = NetworkService(
        client: client,
        decoder: decoder,
      );
      var request = MockAPI.mockDTORequest();

      Result result = await service.request(request);
      switch (result) {
        case (Success()):
          expect(result.success.model.id, 1);
          return;
        case (Failure()):
          throw 'fail test';
      }
    });

    test('Return EmptyDTO', () async {
      var client = MockSuccessNetworkClient(responseData: null);
      var service = NetworkService(client: client);
      var request = MockAPI.emptyDTORequest();

      Result result = await service.request(request);
      switch (result) {
        case (Success()):
          expect(result.success.model.runtimeType, EmptyDTO);
          return;
        case (Failure()):
          throw 'fail test';
      }
    });
  });

  group('Fail Network Request', () {
    test('Throw noConverter', () async {
      var responseData = MockDTO.successJsonData();
      Map<String, dynamic> jsonData = jsonDecode(responseData);
      var client = MockSuccessNetworkClient(responseData: jsonData);
      var decoder = JsonDecoder();
      var service = NetworkService(
        client: client,
        decoder: decoder,
      );
      var request = MockAPI.mockDTORequestNoConverter();

      Result result = await service.request(request);
      switch (result) {
        case (Success()):
          throw 'fail test';
        case (Failure()):
          expect(result.failure.error, NetworkError.noConverter);
          return;
      }
    });

    test('Throw jsondEcode', () async {
      var responseData = MockDTO.failJsonData();
      var client = MockSuccessNetworkClient(responseData: responseData);
      var decoder = JsonDecoder();
      var service = NetworkService(
        client: client,
        decoder: decoder,
      );
      var request = MockAPI.mockDTORequest();

      Result result = await service.request(request);
      switch (result) {
        case (Success()):
          throw 'fail test';
        case (Failure()):
          expect(result.failure.error, NetworkError.jsonDecode);
      }
    });

    test('Throw Client Error with statusCode : 401', () async {
      var statusCode = 401;
      var client = MockFailNetworkClient(
        responseData: null,
        statusCode: statusCode,
      );
      var service = NetworkService(client: client);
      var request = MockAPI.mockDTORequest();

      Result result = await service.request(request);
      switch (result) {
        case (Success()):
          throw 'fail test';
        case (Failure()):
          expect(result.failure.error, NetworkError.clientError);
          expect(result.failure.statusCode, statusCode);
      }
    });

    test('Throw Server Error with statusCode : 501', () async {
      var statusCode = 501;
      var client = MockFailNetworkClient(
        responseData: null,
        statusCode: statusCode,
      );
      var service = NetworkService(client: client);
      var request = MockAPI.mockDTORequest();

      Result result = await service.request(request);
      switch (result) {
        case (Success()):
          throw 'fail test';
        case (Failure()):
          expect(result.failure.error, NetworkError.serverError);
          expect(result.failure.statusCode, statusCode);
      }
    });
  });
}
