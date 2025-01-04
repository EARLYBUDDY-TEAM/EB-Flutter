import 'package:flutter/material.dart';
import 'package:eb_root/eb_root.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:eb_notification_manager/eb_notification_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  widgetsBinding = await PrepareRoot.setup(
    widgetsBinding: widgetsBinding,
    dev: false,
  );
  await NotificationManager.initialize(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    androidDefaultIcon: 'icon_notification',
  );
  final isFirstLaunch = await PrepareRoot.checkFirstLaunch();
  FlutterNativeSplash.remove();

  isFirstLaunch ? runApp(const OnboardingView()) : runApp(RootView());

  // final rootAutoLoginView = RootAutoLoginView();
  // runApp(rootAutoLoginView);
  // await rootAutoLoginView.setAutoLogin();
}
