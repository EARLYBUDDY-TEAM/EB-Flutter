import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'sources/env_kakaomap.dart';
part 'sources/env_server.dart';
part 'sources/env_testuser.dart';

const String ENV_DIR = 'packages/eb_env/assets/env/';

Future<void> prepareENV({bool dev = false}) async {
  await ENV_KAKAOMAP.load();
  await ENV_SERVER.load(dev: dev);
  await ENV_TESTUSER.load();
}
