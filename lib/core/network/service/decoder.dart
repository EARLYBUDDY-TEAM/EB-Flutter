part of 'service.dart';

abstract class NetworkDecoderAB {
  P decode<P>(dynamic data, P Function(dynamic data)? converter);
}

class FoundationDecoder implements NetworkDecoderAB {
  @override
  P decode<P>(data, P Function(dynamic data)? converter) {
    if (converter == null) {
      throw NetworkError.noConverter;
    }
    return converter(data);
  }
}

class JsonDecoder implements NetworkDecoderAB {
  @override
  P decode<P>(data, P Function(dynamic data)? converter) {
    if (converter == null) {
      throw NetworkError.noConverter;
    }

    try {
      Map<String, dynamic> jsonData = data;
      final model = converter(jsonData);
      return model;
    } catch (e) {
      throw NetworkError.jsonDecode;
    }
  }
}
