import 'dart:developer';

import 'package:flutter/material.dart';
import 'sources/home_example.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:eb_secure_storage/eb_secure_storage.dart';
import 'package:eb_env/eb_env.dart';
import 'package:eb_search_place/eb_search_place.dart';
import 'package:eb_location/eb_location.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await prepareAccessToken();
  await prepareENV(dev: true);

  final appKey = ENV_KAKAOMAP.appKey;
  final baseUrl = ENV_KAKAOMAP.url;

  AuthRepository.initialize(
    appKey: appKey,
    baseUrl: baseUrl,
  );

  await LocationProvider.shared.checkPermission();

  runApp(const HomeExample());

  // await Future<void>.delayed(const Duration(seconds: 2));
  // homeDelegate.loginStatus.add(BaseStatus.success);
}

Future<void> prepareAccessToken() async {
  final secureStorage = SecureStorage();
  await secureStorage.write(key: SecureStorageKey.accessToken, value: "");
}
