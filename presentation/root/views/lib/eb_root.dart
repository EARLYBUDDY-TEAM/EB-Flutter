import 'package:eb_delegate/eb_delegate.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:eb_home/eb_home.dart';
import 'package:eb_login/eb_login.dart';
import 'package:eb_root_feature/eb_root_feature.dart';
import 'package:eb_resource/eb_resource.dart';
import 'package:eb_env/eb_env.dart';
import 'package:eb_location/eb_location.dart';
import 'package:eb_search_place/eb_search_place.dart';
import 'package:eb_state/eb_state.dart';
import 'package:eb_secure_storage/eb_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sources/root/root_view.dart';
part 'sources/root/root_bloc_view.dart';
part 'sources/onboarding/onboarding_view.dart';

final class PrepareRoot {
  static Future<WidgetsBinding> setup({
    WidgetsBinding? widgetsBinding,
    bool dev = false,
  }) async {
    final WidgetsBinding myWidgetsBinding =
        widgetsBinding ?? WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting();
    await prepareENV(dev: dev);
    PrepareEBSearchPlace.initializeKakaoMap(
      appKey: ENV_KAKAOMAP.appKey,
      baseUrl: ENV_KAKAOMAP.url,
    );
    await LocationProvider.shared.checkPermission();

    return myWidgetsBinding;
  }

  static Future<bool> checkFirstLaunch() async {
    final List<SecureStorageKey> keysToEliminate = [
      SecureStorageKey.accessToken,
      SecureStorageKey.refreshToken,
    ];

    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      final secureStorage = SecureStorage();
      await Future.wait(
        keysToEliminate.map(
          (key) => secureStorage.delete(key: key),
        ),
      );
      prefs.setBool('first_run', false);
      return true;
    } else {
      return false;
    }
  }
}
