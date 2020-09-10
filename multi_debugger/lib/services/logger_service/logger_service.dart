import 'package:multi_debugger/services/service.dart';
import 'package:logger/logger.dart';

abstract class LoggerService extends Service {
  void setLoggerLevel(Level level);

  void e(dynamic message, [dynamic error, StackTrace stackTrace]);

  void d(dynamic message, [dynamic error, StackTrace stackTrace]);

  void i(dynamic message, [dynamic error, StackTrace stackTrace]);
}
