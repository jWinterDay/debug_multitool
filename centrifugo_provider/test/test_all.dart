import 'package:test/test.dart';

import 'client_test.dart' as client_test;
import 'storage_common_test.dart' as storage_common_test;

void main() {
  group('buffer_test', storage_common_test.main);
  group('client_test', client_test.main);
}
