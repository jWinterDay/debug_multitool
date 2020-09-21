import 'package:multi_debugger/domain/base/base_service.dart';

abstract class LocalStationService extends BaseService {
  Future<String> fetchComputerName({Duration timeout});
}
