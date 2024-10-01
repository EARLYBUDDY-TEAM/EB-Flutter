part of '../eb_env.dart';

final class _DotEnvKakaoMap {
  String appKey = '';
  String url = '';

  static _DotEnvKakaoMap shared = _DotEnvKakaoMap();
}

final class ENV_KAKAOMAP {
  static final _dotEnvKakaoMap = _DotEnvKakaoMap.shared;

  static String get appKey {
    return _dotEnvKakaoMap.appKey;
  }

  static String get url {
    return _dotEnvKakaoMap.url;
  }

  static Future<void> load() async {
    await dotenv.load(fileName: '$ENV_DIR.kakao_api');
    _dotEnvKakaoMap.appKey = dotenv.env['kakao_app_key'] ?? '';
    _dotEnvKakaoMap.url = dotenv.env['kakao_base_url'] ?? '';
  }
}
