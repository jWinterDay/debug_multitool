import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';

import 'main.dart' as main_entry_point;

/// https://github.com/go-flutter-desktop/go-flutter
/// experimental go-flutter plugin
/// to run you should install Hover extension (VSCode)
/// and to run app with console command: hover run
/// then type RUN property: go-flutter_desktop and click F5 to attach go_flutter to flutter process

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  main_entry_point.main();
}
