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
    SavedUrl savedUrl = SavedUrl((b) => b
      ..url = 'fsdfs'
      ..custom = false);
    SavedUrl savedUrl2 = SavedUrl((b) => b
      ..url = 'fsdfs2'
      ..custom = false);

    return [
      savedUrl,
      savedUrl2,
    ];
  }
}
