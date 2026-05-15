import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics;
  CrashlyticsService(this._crashlytics);

  Future<void> setUserIdentifier(String uid) async {
    try {
      await _crashlytics.setUserIdentifier(uid);
    } catch (e) {
      debugPrint('Crashlytics setUserIdentifier: $e');
    }
  }

  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    try {
      await _crashlytics.recordError(
        exception,
        stack,
        reason: reason,
        fatal: fatal,
      );
    } catch (e) {
      debugPrint('Crashlytics recordError: $e');
    }
  }

  void log(String message) {
    try {
      _crashlytics.log(message);
    } catch (e) {
      debugPrint('Crashlytics log: $e');
    }
  }

  Future<void> setCustomKey(String key, String value) async {
    try {
      await _crashlytics.setCustomKey(key, value);
    } catch (e) {
      debugPrint('Crashlytics setCustomKey: $e');
    }
  }
}
