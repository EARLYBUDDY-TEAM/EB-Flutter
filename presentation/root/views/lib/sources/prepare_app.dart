part of '../eb_root.dart';

Future<void> prepareApp({
  bool dev = false,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final env = ENV.shared;
  await env.load(dev: dev);
  _initializeKakaoMap(
    appKey: env.kakaoAppKey,
    baseUrl: "http://localhost:8080",
  );
  await LocationProvider.shared.checkPermission();
}

void _initializeKakaoMap({
  required String appKey,
  required String baseUrl,
}) {
  AuthRepository.initialize(
    appKey: appKey,
    baseUrl: baseUrl,
  );
}
