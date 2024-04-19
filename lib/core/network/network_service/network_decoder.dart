part of 'network_service.dart';

abstract class NetworkDecoderAB {
  P decode<P>(dynamic data, P Function(dynamic data) converter);
}

class JsonDecoder implements NetworkDecoderAB {
  @override
  P decode<P>(data, P Function(dynamic data) converter) {
    if (data is String) {
      Map<String, dynamic> map = jsonDecode(data);
      final model = converter(map);
      return model;
    }
    throw ('Json Decoder Error');
  }
}
