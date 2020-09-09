import 'package:multi_debugger/domain/models/saved_url.dart';
import 'package:multi_debugger/services/service.dart';

abstract class LocalStorageService extends Service {
  Future<List<SavedUrl>> fetchSavedUrlList();
}
