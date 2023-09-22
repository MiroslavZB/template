import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Crashlytics {
  static final _instance = FirebaseCrashlytics.instance;

  static void report(dynamic exception, {StackTrace? trace, bool fatal = false, dynamic reason}) {
    _instance.recordError(exception, trace, fatal: fatal, reason: reason);
  }

  static Future<void> setUserId(String id) async {
    await _instance.setUserIdentifier(id);
  }

  // getters
  static FirebaseCrashlytics get instance => _instance;
}
