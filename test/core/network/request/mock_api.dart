import 'package:earlybuddy/core/network/network_service/network_service.dart';
import '../response/test_model.dart';

class MockAPI {
  static ApiRequest<TestModel> mockRequest() {
    TestModel converter(dynamic responseData) =>
        TestModel.fromJson(responseData);
    return ApiRequest(
      path: '',
      method: HTTPMethod.get,
      converter: converter,
    );
  }
}
