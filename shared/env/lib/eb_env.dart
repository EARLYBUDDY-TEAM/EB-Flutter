import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  String kakaoAppKey = '';
  String kakaoBaseUrl = '';

  String ebServerUrl = '';

  static ENV shared = ENV();

  Future<void> load() async {
    await dotenv.load(fileName: 'packages/eb_env/assets/env/.env');
    kakaoAppKey = dotenv.env['kakao_app_key'] ?? '';
    kakaoBaseUrl = dotenv.env['kakao_baseUrl'] ?? '';
    ebServerUrl = dotenv.env['eb_server_url'] ?? '';
  }
}
