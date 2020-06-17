import 'dart:core';

import 'package:flutter/widgets.dart';

enum ServerTypes { prod, stage, local }

class AppConfig {
  AppConfig._();

  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get rootNavigator => rootNavigatorKey.currentState;

  static void init({bool isUiTesting = false}) {
    _isUiTesting = isUiTesting;
  }

  static bool _isUiTesting = false;
  static bool get isUiTesting => _isUiTesting;

  static const ServerTypes serverType = ServerTypes.stage;
  static bool get isProd => serverType == ServerTypes.prod;
  static const bool useStetho = false;
  static const bool useCustomDelay = true;
  static const Duration customDuration = Duration(seconds: 5);
  static const bool useGoogleAnalytics = false;
  static const bool useYandexAnalytics = false;
  static const int rowCountLimit = 30;

  // local storage keys
  static const String lsProfileState = 'user_profile_state';
  static const String lsIntro = 'intro';

  // db common settings keys
  static const String dbIntroSetting = 'intro';
}
