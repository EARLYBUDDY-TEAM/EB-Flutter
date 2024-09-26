import 'package:flutter/material.dart';
import 'package:eb_root/eb_root.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:eb_secure_storage/eb_secure_storage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  widgetsBinding = await PrepareRoot.setup(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  final isFirstLaunch = await checkFirstLaunch();
  isFirstLaunch ? runApp(const OnboardingView()) : runApp(RootView());
}

Future<bool> checkFirstLaunch() async {
  final secureStorage = SecureStorage();
  try {
    await secureStorage.read(key: SecureStorageKey.isFirstLaunch);
    return false;
  } catch (e) {
    await secureStorage.write(
        key: SecureStorageKey.isFirstLaunch, value: "true");
    return true;
  }
}
