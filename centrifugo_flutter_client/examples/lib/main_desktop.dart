import 'package:flutter/foundation.dart' show TargetPlatform, debugDefaultTargetPlatformOverride;

import 'main.dart' as entry_point;

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  entry_point.main();
}
