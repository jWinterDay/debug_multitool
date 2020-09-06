import 'package:multi_debugger/services/service.dart';

abstract class LocalStationService extends Service {
  Future<String> fetchComputerName({Duration timeout});
}
