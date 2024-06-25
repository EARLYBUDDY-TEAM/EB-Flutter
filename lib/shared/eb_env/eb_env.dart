import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  String kakao_app_key = '';
  String kakao_baseUrl = '';

  String eb_server_url = '';

  static ENV shared = ENV();

  load() async {
    await dotenv.load(fileName: 'assets/env/.env');
    kakao_app_key = dotenv.env['kakao_app_key'] ?? '';
    kakao_baseUrl = dotenv.env['kakao_baseUrl'] ?? '';
    eb_server_url = dotenv.env['eb_server_url'] ?? '';
  }
}
