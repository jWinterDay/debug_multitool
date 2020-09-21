import 'package:multi_debugger/domain/base/base_service.dart';
import 'package:logger/logger.dart';

abstract class LoggerService extends BaseService {
  void setLoggerLevel(Level level);

  void e(dynamic message, [dynamic error, StackTrace stackTrace]);

  void d(dynamic message, [dynamic error, StackTrace stackTrace]);

  void i(dynamic message, [dynamic error, StackTrace stackTrace]);
}
