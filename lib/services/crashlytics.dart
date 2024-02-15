import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

abstract class Crashlytics {
  static final _instance = FirebaseCrashlytics.instance;

  static void report(dynamic exception, {StackTrace? trace, bool fatal = false, dynamic reason}) {
    if (kDebugMode) {
      log('Crashlytics.report: $exception\ntrace: $trace\nreason: $reason');
    } else {
      _instance.recordError(exception, trace, fatal: fatal, reason: reason);
    }
  }

  static Future<void> setUserId(String id) async => await _instance.setUserIdentifier(id);

  static bool recordPlatformError(dynamic exception, StackTrace trace) {
    if (kDebugMode) {
      log('Crashlytics.recordPlatformError: $exception\ntrace: $trace');
    } else {
      FirebaseCrashlytics.instance.recordError(exception, trace, fatal: true);
    }
    return true;
  }

  static Future<void> Function(FlutterErrorDetails flutterErrorDetails) recordFlutterError =
      FirebaseCrashlytics.instance.recordFlutterFatalError;

  static FirebaseCrashlytics get instance => _instance;
}
