part of '../eb_event.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final class NotificationEvent {
  final checkScheduleAlertDuration = const Duration(minutes: 1);

  Schedule? _imminentSchedule;
  StreamSubscription<dynamic>? _timerSubscription;

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (_) {
        log("onDidReceiveNotificationResponse");
      },
    );
  }

  Future<void> _tearDownStream() async {
    _imminentSchedule = null;
    await _timerSubscription?.cancel().then((_) {
      _timerSubscription = null;
    });
  }

  DateTime _removeSecond(DateTime dateTime) {
    return dateTime.copyWith(
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  Future<void> setScheduleNotification({
    required Schedule? schedule,
  }) async {
    await _tearDownStream();

    if (schedule?.notifySchedule == null) {
      return;
    }

    _imminentSchedule = schedule;

    _timerSubscription =
        Stream.periodic(checkScheduleAlertDuration).listen((_) async {
      final notifySchedule = _imminentSchedule!.notifySchedule!;

      final now = _removeSecond(DateTime.now());
      final alertScheduleTime =
          _imminentSchedule!.time.add(Duration(minutes: -notifySchedule));
      final compareResult =
          EBTime.compareDate(left: now, right: alertScheduleTime);
      log("checkckckckckckkc : ${compareResult.toString()}");
      if (compareResult == CompareDateResult.same) {
        await _notifyScheduleAlert(
          scheduleTitle: _imminentSchedule!.title,
          notifySchedule: notifySchedule,
        );
        await _tearDownStream();
      }
    });
  }

  Future<void> _notifyScheduleAlert({
    required String scheduleTitle,
    required int notifySchedule,
  }) async {
    final title = scheduleTitle;
    final body = '일정 시작까지 $notifySchedule분 남았습니다.';
    await _show(
      title: title,
      body: body,
    );
  }

  Future<void> _show({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'item x',
    );
  }
}
