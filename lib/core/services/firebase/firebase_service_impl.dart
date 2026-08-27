import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/core/services/firebase/firebase_service.dart';
import 'package:flutter_template/core/services/notification/notification_service.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/logger/app_logger.dart';

/// do not call this class directly
/// use [AbsFirebaseService] instead
@LazySingleton(as: AbsFirebaseService)
class FirebaseServiceImpl implements AbsFirebaseService {
  @override
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    Future.wait([
      initializeFirebaseNotification(),
      initializeFirebaseCrashlytics(),
    ]);
  }

  @override
  Future<void> initializeFirebaseNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    /// ask for permission
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
      AppLogger.info("Permission granted");
    } else {
      AppLogger.warning("Permission denied");
    }

    await NotificationService().initializeLocalNotification();
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessagingHandler);
  }

  @override
  Future<void> initializeFirebaseCrashlytics() async {
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      // Pass all uncaught "fatal" errors from the framework to Crashlytics
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  @override
  Future<String> getFcmToken() async {
    final fcm = FirebaseMessaging.instance;
    final String? token = await fcm.getToken();
    AppLogger.debug('FCM Token: $token');
    return token ?? "Failed to get Token";
  }
}
