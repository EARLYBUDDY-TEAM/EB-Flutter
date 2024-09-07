import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  String kakaoAppKey = '';
  String ebServerUrl = '';

  static ENV shared = ENV();

  Future<void> load({
    required bool dev,
  }) async {
    String envfile = dev ? ".env_dev" : ".env_main";
    await dotenv.load(fileName: 'packages/eb_env/assets/env/$envfile');
    kakaoAppKey = dotenv.env['kakao_app_key'] ?? '';
    ebServerUrl = dotenv.env['eb_server_url'] ?? '';
  }
}
