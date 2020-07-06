import 'dart:io';

import 'package:centrifugo_flutter_client/src/models/app_state.dart';
import 'package:centrifugo_flutter_client/src/models/channel.dart';
import 'package:centrifugo_flutter_client/src/models/used_url.dart';
import 'package:centrifugo_flutter_client/src/repositories/logger_repository.dart';
import 'package:centrifugo_flutter_client/src/utils/hive_boxes.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageRepository {
  LocalStorageRepository(this.loggerRepository);

  final LoggerRepository loggerRepository;

  Box<AppState> _appStateBox;
  Box<UsedUrl> _usedUrlBox;
  Box<Channel> _channelBox;

  /// init local storage repository
  Future<void> init() async {
    // hive adapter
    Hive.registerAdapter<UsedUrl>(UsedUrlAdapter());
    Hive.registerAdapter<Channel>(ChannelAdapter());
    Hive.registerAdapter<AppState>(AppStateAdapter());

    // hive init
    final Directory appDocDir = await getApplicationDocumentsDirectory(); // getTemporaryDirectory();
    loggerRepository.d('hive path: ${appDocDir.path}');
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
    // check exists
    final bool exists = _usedUrlBox.values.any(
      (UsedUrl usedUrlItem) => usedUrlItem.name == usedUrl.name,
    );
    if (!exists) {
      final int key = await _usedUrlBox.add(usedUrl);
      loggerRepository.d('key: $key');
    }

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

  Future<void> deleteUsedUrl(dynamic key) async {
    await _usedUrlBox.delete(key);
  }

  Future<void> deleteAllUsedUrls() async {
    final Map<dynamic, UsedUrl> rawMap = _usedUrlBox.toMap();
    final List<dynamic> keys = rawMap.values.where((UsedUrl usedUrl) {
      return !usedUrl.isPermanent;
    }).map<dynamic>((UsedUrl usedUrl) {
      return usedUrl.key;
    }).toList();

    await _usedUrlBox.deleteAll(keys);
  }

  Future<void> saveChannel(Channel channel) async {
    // check exists
    final bool exists = _channelBox.values.any(
      (Channel channelItem) => channelItem.name == channel.name,
    );
    if (!exists) {
      final int key = await _channelBox.add(Channel(
        name: channel.name,
      ));
      loggerRepository.d('key: $key');
    }

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

  Future<void> deleteChannel(dynamic key) async {
    await _channelBox.delete(key);
  }

  Future<void> deleteAllChannels() async {
    await _channelBox.clear();
  }

  void close() {
    _usedUrlBox.close();
    _channelBox.close();
    _appStateBox.close();
    Hive.close();
  }
}
