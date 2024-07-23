import 'dart:developer';

import 'package:earlybuddy/presentation/auth/login/example/login_example.dart';
import 'package:earlybuddy/presentation/auth/root/view/root_view.dart';
import 'package:earlybuddy/presentation/schedule/addschedule/example/addschedule_example.dart';
import 'package:earlybuddy/presentation/schedule/detailroute/example/detailroute_example.dart';
import 'package:earlybuddy/presentation/schedule/searchplace/example/searchplace_example.dart';
import 'package:earlybuddy/presentation/schedule/findroute/example/findroute_example.dart';
import 'package:earlybuddy/shared/eb_env/eb_env.dart';
import 'package:earlybuddy/shared/eb_uikit/example/eb_uikit_example.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final env = ENV.shared;
  await env.load();
  initializeKakaoMap(appKey: env.kakao_app_key, baseUrl: env.kakao_baseUrl);

  // runApp(RootView());
  // runApp(const KakaoMapExample());
  // await getlocationdda

  runApp(const LoginExample());
  // runApp(const EBUIkitExample());
  // runApp(const SearchPlaceExample());
  // runApp(const AddScheduleExample());
  // runApp(const FindRouteExample());
  // runApp(const DetailRouteExample());
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
