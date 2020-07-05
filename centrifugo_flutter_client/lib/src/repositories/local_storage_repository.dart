import 'dart:io';

import 'package:centrifugo_flutter_client/src/models/app_state.dart';
import 'package:centrifugo_flutter_client/src/models/channel.dart';
import 'package:centrifugo_flutter_client/src/models/used_url.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageRepository {
  Future<void> init() async {
    // hive adapter
    Hive.registerAdapter<UsedUrl>(UsedUrlAdapter());
    Hive.registerAdapter<Channel>(ChannelAdapter());
    Hive.registerAdapter<AppState>(AppStateAdapter());

    // hive init
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    // getTemporaryDirectory();
    debugPrint('hive path: ${appDocDir.path}');
    Hive.init(appDocDir.path);

    // _appStateBox = await Hive.openBox<AppState>(HiveBoxes.appState);
    // _usedUrlBox = await Hive.openBox<UsedUrl>(HiveBoxes.usedUrl);
    // _channelBox = await Hive.openBox<Channel>(HiveBoxes.channel);

    // // last url and channel
    // final AppState appState = _appStateBox.get(0);
    // centrifugoUrlTextController.text = appState?.currentUrl ?? '';
    // centrifugoChannelTextController.text = appState?.currentChannel ?? '';

    // persistent data
  }
}
