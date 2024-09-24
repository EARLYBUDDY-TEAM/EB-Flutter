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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';

part 'sources/root/root_view.dart';
part 'sources/splash/splash_view.dart';
part 'sources/root/root_bloc_view.dart';
part 'sources/onboarding/onboarding_view.dart';

final class PrepareRoot {
  static Future<void> setup({
    bool dev = false,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting();
    await PrepareENV.load(dev: true);
    PrepareEBSearchPlace.initializeKakaoMap(
      appKey: ENV.shared.kakaoAppKey,
      baseUrl: ENV.shared.kakaoBaseUrl,
    );
    await LocationProvider.shared.checkPermission();
  }
}
