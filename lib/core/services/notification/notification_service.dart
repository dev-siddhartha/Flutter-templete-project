import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_template/core/utils/logger/app_logger.dart';
import 'package:flutter_template/core/widgets/show_toast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void localBackgroundMessagingHandler(
    NotificationResponse notificationResponse) {
  // handle action
  AppLogger.info(
      'Background notification tapped: ${notificationResponse.payload}');
}

@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessagingHandler(RemoteMessage message) async {
  AppLogger.info("Background message received: $message");

  if (message.notification == null) {
    await NotificationService().initializeLocalNotification();
    await NotificationService().showNotification(message);
  }

  /// do not handle redirection here. it is handled in [_handleNotification] function below.
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeLocalNotification() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('ic_launcher');

      /// used for ios
      const IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings();

      /// previously used for both ios and macos but now, From 21.0.0 it is only used for macos
      const DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings();
      const LinuxInitializationSettings initializationSettingsLinux =
          LinuxInitializationSettings(defaultActionName: 'Open notification');
      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS,
              macOS: initializationSettingsDarwin,
              linux: initializationSettingsLinux);

      await flutterLocalNotificationsPlugin.initialize(
        settings: initializationSettings,
        onDidReceiveNotificationResponse: localBackgroundMessagingHandler,
        onDidReceiveBackgroundNotificationResponse:
            localBackgroundMessagingHandler,
      );
    } catch (e) {
      AppLogger.error('Error initializing local notification: $e', error: e);
    }

    await _handleNotification();
  }

  Future<bool?> requestPermission() async {
    /// permission for ios
    /// no need for android
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'general_notification',
      'General Notification',
      channelDescription: 'General Reminder Notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    /// mostly of the parameters are changed to named parameters in 21.0.0
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: notificationDetails,
      payload: json.encode(message.data),
    );
  }

  Future<void> _handleNotification() async {
    /// Handle FCM notification when the app is in the foreground
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      AppLogger.info('Foreground message received: $remoteMessage');

      AppToast.showToast(remoteMessage.notification?.body ?? '');
      showNotification(remoteMessage);
    });

    /// Handle when the user taps on a notification and opens the app from background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      AppLogger.info('Notification opened from background: $event');

      //! TODO: Handle redirection
    });

    /// Handle when the app is opened from a terminated state via a FCM notification
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      //! TODO: Handle redirection
    }

    /// Handle when app opens via local notification
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      //! TODO: Handle redirection
    }
  }
}
