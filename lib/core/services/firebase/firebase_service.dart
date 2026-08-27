abstract class AbsFirebaseService {
  Future<void> initializeFirebase() async {}

  Future<void> initializeFirebaseNotification() async {}

  Future<void> initializeFirebaseCrashlytics() async {}

  Future<String> getFcmToken();
}
