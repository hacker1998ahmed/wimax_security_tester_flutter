import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _notifications.initialize(
      const InitializationSettings(android: android),
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'channel_id',
      'WiMax Alerts',
      importance: Importance.high,
    );
    await _notifications.show(
      0,
      title,
      body,
      const NotificationDetails(android: android),
    );
  }
}