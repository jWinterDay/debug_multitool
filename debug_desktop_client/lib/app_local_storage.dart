// import 'dart:async';

import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/mobx/channel_list.dart';
import 'package:debug_desktop_client/services/local_storage_service.dart';
import 'package:debug_desktop_client/services/logger_service.dart';

class AppLocalStorage {
  static Future<void> init() async {
    LoggerService loggerService = di.get<LoggerService>();

    LocalStorageService localStorageService = di.get<LocalStorageService>();
    await localStorageService.init();

    // Channel channel1 = Channel()..name = '1';
    // final String str = channel1.toJson();
    // print('str = $str');

    // final t = Channel.fromJson(str);
    // print(t?.name);

    // Channel channel2 = Channel()..name = '1';
    // final String str2 = channel2.toJson();

    ChannelList list = ChannelList();
    list.addChannel('name1');
    list.addChannel('name2');

    final String str = list.toJson();
    // print('-=------- str = $str');

    ChannelList f = ChannelList.fromJson(str);
    // print('converted list = $f');

    // await localStorageService.setStringList('channels', ['fds', '>>>']);

    // final channels = localStorageService.getStringList('channels');

    // print(channels);

    loggerService.d('---local storage successfully initialized---');
  }
}
