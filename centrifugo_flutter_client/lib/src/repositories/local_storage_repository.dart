import 'dart:io';

import 'package:centrifugo_flutter_client/src/models/app_state.dart';
import 'package:centrifugo_flutter_client/src/models/channel.dart';
import 'package:centrifugo_flutter_client/src/models/used_url.dart';
import 'package:centrifugo_flutter_client/src/repositories/logger_repository.dart';
import 'package:centrifugo_flutter_client/src/utils/hive_boxes.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageRepository {
  final LoggerRepository _logger = LoggerRepository();

  Box<AppState> _appStateBox;
  Box<UsedUrl> _usedUrlBox;
  Box<Channel> _channelBox;

  Future<void> init() async {
    // hive adapter
    Hive.registerAdapter<UsedUrl>(UsedUrlAdapter());
    Hive.registerAdapter<Channel>(ChannelAdapter());
    Hive.registerAdapter<AppState>(AppStateAdapter());

    // hive init
    final Directory appDocDir = await getApplicationDocumentsDirectory(); // getTemporaryDirectory();
    _logger.d('hive path: ${appDocDir.path}');
    Hive.init(appDocDir.path);

    _appStateBox = await Hive.openBox<AppState>(HiveBoxes.appState);
    _usedUrlBox = await Hive.openBox<UsedUrl>(HiveBoxes.usedUrl);
    _channelBox = await Hive.openBox<Channel>(HiveBoxes.channel);

    await _saveInitialValues();
  }

  Future<void> _saveInitialValues() async {
    // url
    if (_usedUrlBox.isEmpty) {
      final Iterable<UsedUrl> usedUrlList = <UsedUrl>[
        UsedUrl(
          name: 'ws://172.16.55.141:8001/connection/websocket?format=protobuf',
          isPermanent: true,
        ),
        UsedUrl(
          name: 'ws://localhost:8001/connection/websocket?format=protobuf',
          isPermanent: true,
        )
      ];

      await _usedUrlBox.addAll(usedUrlList);
    }

    // channel
    if (_channelBox.isEmpty) {
      await _channelBox.add(Channel(
        name: 'dev',
      ));
    }
  }

  String get lastUsedUrl {
    final AppState appState = _appStateBox.get(0);
    return appState?.currentUrl ?? '';
  }

  String get lastUsedChannel {
    final AppState appState = _appStateBox.get(0);
    return appState?.currentChannel ?? '';
  }

  Future<void> saveUsedUrl(UsedUrl usedUrl) async {
    final int key = await _usedUrlBox.add(usedUrl);
    _logger.d('key: $key');

    // update state
    if (_appStateBox.isEmpty) {
      await _appStateBox.add(
        AppState(currentUrl: usedUrl.name),
      );
    } else {
      final AppState appState = _appStateBox.getAt(0);
      appState.currentUrl = usedUrl.name;
      await appState.save();
    }
  }

  Future<void> saveChannel(Channel channel) async {
    final int key = await _channelBox.add(Channel(
      name: channel.name,
    ));
    _logger.d('key: $key');

    // update state
    if (_appStateBox.isEmpty) {
      await _appStateBox.add(AppState(
        currentChannel: channel.name,
      ));
    } else {
      final AppState appState = _appStateBox.getAt(0);
      appState.currentChannel = channel.name;
      await appState.save();
    }
  }

  void close() {
    _usedUrlBox.close();
    _channelBox.close();
    _appStateBox.close();
    Hive.close();
  }
}
