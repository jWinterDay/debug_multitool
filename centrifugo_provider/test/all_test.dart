import 'package:test/test.dart';

import 'sender_wo_buffer_test.dart' as sender_wo_buffer_test;
import 'storage_buffer_test.dart' as storage_buffer_test;
import 'storage_common_test.dart' as storage_common_test;

void main() {
  group('storage_common_test', storage_common_test.main);
  group('storage_buffer_test', storage_buffer_test.main);

  group('sender_wo_buffer_test', sender_wo_buffer_test.main);
}
