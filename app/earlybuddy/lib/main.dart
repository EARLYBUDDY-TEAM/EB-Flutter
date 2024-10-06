import 'package:flutter/material.dart';
import 'package:eb_root/eb_root.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  widgetsBinding = await PrepareRoot.setup(
    widgetsBinding: widgetsBinding,
    dev: true,
  );
  final isFirstLaunch = await PrepareRoot.checkFirstLaunch();
  FlutterNativeSplash.remove();
  isFirstLaunch ? runApp(const OnboardingView()) : runApp(RootView());
}
