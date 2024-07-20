import 'package:earlybuddy/domain/network/sources/endpoint/response/dto.dart';
import 'package:earlybuddy/domain/network/sources/network_service/network_service.dart';
import '../response/mock_dto.dart';

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
