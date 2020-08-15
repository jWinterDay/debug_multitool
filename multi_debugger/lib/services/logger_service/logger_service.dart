import 'package:multi_debugger/services/service.dart';

abstract class LoggerService extends Service {
  void e(dynamic message, [dynamic error, StackTrace stackTrace]);

  void d(dynamic message, [dynamic error, StackTrace stackTrace]);

  void i(dynamic message, [dynamic error, StackTrace stackTrace]);
}
