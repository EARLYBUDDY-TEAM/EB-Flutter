import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:eb_env/eb_env.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:eb_location/eb_location.dart';
import 'package:eb_root/eb_root.dart';

void main() async {
  await prepareApp();
  runApp(RootView());
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
