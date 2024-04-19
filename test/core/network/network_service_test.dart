import 'package:earlybuddy/core/network/network_service.dart';
import 'package:test/test.dart';

import 'test_model.dart';

void main() {
  test('test JsonDecoder decode', () {
    var networkDecoder = JsonDecoder();
    dynamic data = TestModel.jsonData();

    converter(dynamic data) => TestModel.fromJson(data);

    TestModel model = networkDecoder.decode<TestModel>(data, converter);
    expect(model.id, 1);
  });
}
