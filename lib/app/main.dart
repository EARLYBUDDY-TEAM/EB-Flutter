import 'dart:developer';

import 'package:earlybuddy/core/provider/location/location_provider.dart';
import 'package:earlybuddy/domain/repository/ebauth/ebauth_repository.dart';
import 'package:earlybuddy/presentation/auth/login/example/login_example.dart';
import 'package:earlybuddy/presentation/auth/register/example/register_example.dart';
import 'package:earlybuddy/presentation/root/example/root_example.dart';
import 'package:earlybuddy/presentation/root/view/root_view.dart';
import 'package:earlybuddy/presentation/home/example/home_example.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/example/addschedule_example.dart';
import 'package:earlybuddy/presentation/schedule/detailroute/example/detailroute_example.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/example/searchplace_example.dart';
import 'package:earlybuddy/presentation/schedule/findroute/example/findroute_example.dart';
import 'package:earlybuddy/shared/env/env.dart';
import 'package:earlybuddy/shared/eb_uikit/example/eb_uikit_example.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

void main() async {
  await prepareApp();

  await runAppRootExample();

  // runApp(const KakaoMapExample());
  // await getlocationdda

  // runApp(const RootExample());
  // runApp(const LoginExample());
  // runApp(const RegisterExample());

  // runApp(const HomeExample());

  // runApp(const EBUIkitExample());
  // runApp(const SearchPlaceExample());
  // runApp(const AddScheduleExample());
  // runApp(const FindRouteExample());
  // runApp(const DetailRouteExample());
}

Future<void> prepareApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final env = ENV.shared;
  await env.load();
  initializeKakaoMap(appKey: env.kakaoAppKey, baseUrl: env.kakaoBaseUrl);
  await LocationProvider.shared.checkPermission();
}

void initializeKakaoMap({
  required String appKey,
  required String baseUrl,
}) {
  AuthRepository.initialize(
    appKey: appKey,
    baseUrl: baseUrl,
  );
}

Future<void> runAppRootExample() async {
  final rootExample = RootExample();
  runApp(rootExample);
  await rootExample.init();
}
