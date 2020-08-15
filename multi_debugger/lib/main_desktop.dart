import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';

import 'main.dart' as original_main;

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.linux;
  await original_main.main();
}
