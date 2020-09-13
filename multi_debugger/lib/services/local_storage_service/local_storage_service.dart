import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/services/service.dart';

abstract class LocalStorageService extends Service {
  Future<void> initStorage();

  // saved urls
  Future<List<SavedUrl>> fetchSavedUrlList();

  Future<void> saveSavedUrls(SavedUrlState savedUrlState);

  // channel state
  Future<List<ChannelModel>> fetchSavedChannelsList();

  Future<void> saveChannelState(ChannelState channelState);
}
