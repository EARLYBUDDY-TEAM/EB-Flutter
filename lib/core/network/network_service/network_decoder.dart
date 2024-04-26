part of 'network_service.dart';

abstract class NetworkDecoderAB {
  P decode<P>(dynamic data, P Function(dynamic data)? converter);
}

class JsonDecoder implements NetworkDecoderAB {
  @override
  P decode<P>(data, P Function(dynamic data)? converter) {
    if (converter == null) {
      throw NetworkError.noConverter;
    }

    try {
      Map<String, dynamic> jsonData = data;
      log('check');
      log('$jsonData');
      final model = converter(jsonData);
      return model;
    } catch (e) {
      log(e.toString());
      throw NetworkError.jsonDecode;
    }
  }
}
