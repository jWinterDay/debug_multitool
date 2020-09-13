import 'package:multi_debugger/domain/models/models.dart';

import 'local_storage_service.dart';

class LocalStorageServiceImpl extends LocalStorageService {
  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<List<SavedUrl>> fetchSavedUrlList() async {
    return [
      SavedUrl((b) => b
        ..url = 'ws://localhost:8001/connection/websocket?format=protobuf'
        ..custom = false),
      SavedUrl((b) => b
        ..url = 'ws://172.16.55.141:8001/connection/websocket?format=protobuf'
        ..custom = true)
    ];
  }

  @override
  Future<List<ChannelModel>> fetchSavedChannelsList() async {
    return [
      ChannelModel((b) => b
        ..name = 'dev'
        ..shortName = 'dev'),
      ChannelModel((b) => b
        ..name = 'testing'
        ..shortName = 'testing'),
      ChannelModel((b) => b
        ..name = 'analytics'
        ..shortName = 'analytics'),
    ];
  }
}
