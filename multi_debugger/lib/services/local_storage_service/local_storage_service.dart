import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/services/service.dart';

abstract class LocalStorageService extends Service {
  Future<List<SavedUrl>> fetchSavedUrlList();

  Future<List<ChannelModel>> fetchSavedChannelsList();
}
