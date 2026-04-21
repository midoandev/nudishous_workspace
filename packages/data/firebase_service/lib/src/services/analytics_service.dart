import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  Future<void> logLogin({required String method}) =>
      _analytics.logLogin(loginMethod: method);

  Future<void> logScreenView({required String screenName}) =>
      _analytics.logScreenView(screenName: screenName);

  Future<void> setUserId(String userId) =>
      _analytics.setUserId(id: userId);

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) => _analytics.logEvent(name: name, parameters: parameters);
}