import 'package:eb_model/dto/dto.dart';
import 'package:eb_network/sources/service/service.dart';
import 'package:eb_network_interface/network_ab.dart';
import 'package:eb_network_test/endpoint/response/mock_dto.dart';

class MockAPI {
  static ApiRequest<MockDTO> mockDTORequest() {
    MockDTO converter(dynamic responseData) => MockDTO.fromJson(responseData);
    return ApiRequest(
      path: '',
      method: HTTPMethod.get,
      converter: converter,
    );
  }

  static ApiRequest<MockDTO> mockDTORequestNoConverter() {
    return ApiRequest(
      path: '',
      method: HTTPMethod.get,
      converter: null,
    );
  }

  static ApiRequest<EmptyDTO> emptyDTORequest() {
    return ApiRequest(
      path: '',
      method: HTTPMethod.get,
    );
  }
}
