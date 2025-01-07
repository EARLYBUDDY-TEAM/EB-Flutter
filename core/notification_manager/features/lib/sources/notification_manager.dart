part of '../eb_notification_manager.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.notification?.title.toString()}");
}

late EBLocalNotification _ebLocalNotification;

final class NotificationManager {
  final FirebaseOptions firebaseOptions;
  final String androidDefaultIcon;

  NotificationManager({
    required this.firebaseOptions,
    required this.androidDefaultIcon,
  }) {
    _ebLocalNotification = EBLocalNotification(
      androidDefaultIcon: androidDefaultIcon,
    );
  }

  static Future<void> initialize({
    required FirebaseOptions firebaseOptions,
    required String androidDefaultIcon,
  }) async {
    try {
      final result = await InternetAddress.lookup('www.naver.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('network connected');

        final self = NotificationManager(
          firebaseOptions: firebaseOptions,
          androidDefaultIcon: androidDefaultIcon,
        );

        await self._init();
      }
    } on SocketException catch (_) {
      log('network not connected');
    }
  }

  Future<void> _init() async {
    await _initializeAndPermission();
    await _ebLocalNotification.initialize();
    await _setupFCM();
  }

  static Future<String?> getFCMToken() async {
    try {
      final result = await InternetAddress.lookup('www.naver.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('network connected');

        final fcmToken = await FirebaseMessaging.instance.getToken();
        log("Call getFCMToken: $fcmToken");
        return fcmToken;
      }
    } on SocketException catch (_) {
      log('network not connected');
      return null;
    }
    return null;
  }
}

/// Initialize Firebase and request notification permission
extension on NotificationManager {
  Future<void> _initializeAndPermission() async {
    await _initializeFirebase();
    await _requestNotificationPermission();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(
      options: firebaseOptions,
    );
  }

  Future<void> _requestNotificationPermission() async {
    final messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('authorized !!!');
      final fcmToken = await messaging.getToken();
      log('fcmToken: $fcmToken');
    }
  }
}

/// Setup FCM, listen foreground, background messages
extension on NotificationManager {
  Future<void> _setupFCM() async {
    await _setupiOS();
    await _setupAndroid();
  }
}

extension on NotificationManager {
  Future<void> _setupiOS() async {
    if (!Platform.isIOS) {
      return;
    }
    // FCM
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

extension on NotificationManager {
  Future<void> _setupAndroid() async {
    if (!Platform.isAndroid) {
      return;
    }

    // FCM
    await _ebLocalNotification.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_ebLocalNotification.androidChannel);

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      final notification = initialMessage.notification;
      log(notification?.title.toString() ?? 'no title');
    }

    // Foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        log("onMessage");
        await _ebLocalNotification.pushAndroid(message: message);
      },
    );

    // Background
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }
}
