import 'dart:convert';
import 'package:eb_network/eb_network.dart';
import 'package:eb_network_interface/eb_network_interface.dart';
import 'package:eb_network_test/eb_network_testing.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_model/dto.dart';
import 'package:flutter_test/flutter_test.dart';

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

      NetworkResponse<MockDTO> result = await service.request(request);
      switch (result) {
        case (SuccessResponse()):
          expect(result.model.id, 1);
          return;
        case (FailureResponse()):
          throw 'fail test';
      }
    });

    test('Return EmptyDTO', () async {
      var client = MockSuccessNetworkClient(responseData: null);
      var service = NetworkService(client: client);
      var request = MockAPI.emptyDTORequest();

      NetworkResponse<EmptyDTO> result = await service.request(request);
      switch (result) {
        case (SuccessResponse()):
          expect(result.model.runtimeType, EmptyDTO);
          return;
        case (FailureResponse()):
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

      NetworkResponse<MockDTO> result = await service.request(request);
      switch (result) {
        case (SuccessResponse()):
          throw 'fail test';
        case (FailureResponse()):
          expect(result.error, NetworkError.noConverter);
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

      NetworkResponse<MockDTO> result = await service.request(request);
      switch (result) {
        case (SuccessResponse()):
          throw 'fail test';
        case (FailureResponse()):
          expect(result.error, NetworkError.jsonDecode);
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

      NetworkResponse<MockDTO> result = await service.request(request);
      switch (result) {
        case (SuccessResponse()):
          throw 'fail test';
        case (FailureResponse()):
          expect(result.error, NetworkError.clientError);
          expect(result.statusCode, statusCode);
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

      NetworkResponse<MockDTO> result = await service.request(request);
      switch (result) {
        case (SuccessResponse()):
          throw 'fail test';
        case (FailureResponse()):
          expect(result.error, NetworkError.serverError);
          expect(result.statusCode, statusCode);
      }
    });
  });
}
