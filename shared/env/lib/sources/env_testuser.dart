part of '../eb_env.dart';

final class _DotEnvTestUser {
  String name = '';
  String email = '';
  String password = '';

  static _DotEnvTestUser shared = _DotEnvTestUser();
}

final class ENV_TESTUSER {
  static final _dotEnvTestUser = _DotEnvTestUser.shared;

  static String get name {
    return _dotEnvTestUser.name;
  }

  static String get email {
    return _dotEnvTestUser.email;
  }

  static String get password {
    return _dotEnvTestUser.password;
  }

  static Future<void> load() async {
    await dotenv.load(fileName: '$ENV_DIR.test_user');
    _dotEnvTestUser.name = dotenv.env['name'] ?? '';
    _dotEnvTestUser.email = dotenv.env['email'] ?? '';
    _dotEnvTestUser.password = dotenv.env['password'] ?? '';
  }
}
