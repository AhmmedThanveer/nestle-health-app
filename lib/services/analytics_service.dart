import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics;
  AnalyticsService(this._analytics);

  Future<void> setUserId(String uid) async {
    try {
      await _analytics.setUserId(id: uid);
    } catch (e) {
      debugPrint('Analytics setUserId: $e');
    }
  }

  Future<void> logLogin() async {
    try {
      await _analytics.logLogin(loginMethod: 'email');
    } catch (e) {
      debugPrint('Analytics logLogin: $e');
    }
  }

  Future<void> logSignUp() async {
    try {
      await _analytics.logSignUp(signUpMethod: 'email');
    } catch (e) {
      debugPrint('Analytics logSignUp: $e');
    }
  }

  Future<void> logScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);
    } catch (e) {
      debugPrint('Analytics logScreenView: $e');
    }
  }

  Future<void> logEvent(String name, [Map<String, Object>? params]) async {
    try {
      await _analytics.logEvent(name: name, parameters: params);
    } catch (e) {
      debugPrint('Analytics logEvent: $e');
    }
  }

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);
}
