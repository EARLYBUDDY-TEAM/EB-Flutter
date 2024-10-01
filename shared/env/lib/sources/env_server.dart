part of '../eb_env.dart';

final class _DotEnvServer {
  String url = '';

  static _DotEnvServer shared = _DotEnvServer();
}

final class ENV_SERVER {
  static final _dotEnvServer = _DotEnvServer.shared;

  static String get url {
    return _dotEnvServer.url;
  }

  static Future<void> load({required bool dev}) async {
    String envfile = dev ? ".server_dev" : ".server_main";
    await dotenv.load(fileName: '$ENV_DIR$envfile');
    _dotEnvServer.url = dotenv.env['eb_server_url'] ?? '';
  }
}
