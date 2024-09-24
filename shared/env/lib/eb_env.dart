import 'package:flutter_dotenv/flutter_dotenv.dart';

final class ENV {
  String kakaoAppKey = '';
  String kakaoBaseUrl = '';
  String ebServerUrl = '';

  static ENV shared = ENV();
}

final class PrepareENV {
  static Future<void> load({required bool dev}) async {
    String envfile = dev ? ".env_dev" : ".env_main";
    await dotenv.load(fileName: 'packages/eb_env/assets/env/$envfile');
    ENV.shared.kakaoAppKey = dotenv.env['kakao_app_key'] ?? '';
    ENV.shared.kakaoBaseUrl = dotenv.env['kakao_base_url'] ?? '';
    ENV.shared.ebServerUrl = dotenv.env['eb_server_url'] ?? '';
  }
}
