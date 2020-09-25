import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:multi_debugger/domain/serializers.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:multi_debugger/domain/models/models.dart';

import 'local_storage_service.dart';

const String _kMultiDebuggerName = 'multiDebugger';

const String _kChannelStateKey = 'channelState';
const String _kSavedUrlKey = 'savedUrl';

class LocalStorageServiceImpl extends LocalStorageService {
  LocalStorageServiceImpl({
    @required this.loggerService,
  }) : assert(loggerService != null);
  final LoggerService loggerService;

  Box<String> _localStorageBox;

  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    _localStorageBox.close();

    super.dispose();
  }

  Future<void> _checkBoxOpen() async {
    final bool open = _localStorageBox?.isOpen ?? false;

    if (!open) {
      _localStorageBox = await Hive.openBox<String>(_kMultiDebuggerName);
    }
  }

  @override
  Future<void> initStorage() async {
    if (!kIsWeb) {
      final Directory appDocumentDirectory = await path_provider.getTemporaryDirectory(); //getDownloadsDirectory();
      Hive.init(appDocumentDirectory.path);
    }
  }

  @override
  Future<List<SavedUrl>> fetchSavedUrlList() async {
    await _checkBoxOpen();

    List<SavedUrl> savedUrlList;
    String data;

    try {
      data = await _localStorageBox.get(_kSavedUrlKey);

      final SavedUrlState savedUrlState = serializers.deserializeWith(SavedUrlState.serializer, json.decode(data));

      savedUrlList = savedUrlState.urls.values.map((SavedUrl su) => su).toList();
    } catch (error, stackTrace) {
      if (data != null) {
        loggerService.e(error, error.runtimeType, stackTrace);
      }

      // return default list
      savedUrlList = [
        SavedUrl((b) => b
          ..url = 'ws://localhost:8001/connection/websocket?format=protobuf'
          ..custom = false),
        SavedUrl((b) => b
          ..url = 'ws://172.16.55.141:8001/connection/websocket?format=protobuf'
          ..custom = true)
      ];
    }

    return savedUrlList;
  }

  @override
  Future<void> saveSavedUrls(SavedUrlState savedUrlState) async {
    await _checkBoxOpen();

    try {
      final String savedUrlsStateStr = json.encode(serializers.serializeWith(SavedUrlState.serializer, savedUrlState));

      await _localStorageBox.put(_kSavedUrlKey, savedUrlsStateStr);
    } catch (error, stackTrace) {
      loggerService.e(error, error.runtimeType, stackTrace);
    }
  }

  @override
  Future<void> saveChannelState(ChannelState channelState) async {
    await _checkBoxOpen();

    try {
      final String channelStateStr = json.encode(serializers.serializeWith(ChannelState.serializer, channelState));

      await _localStorageBox.put(_kChannelStateKey, channelStateStr);
    } catch (error, stackTrace) {
      loggerService.e(error, error.runtimeType, stackTrace);
    }
  }

  @override
  Future<List<ChannelModel>> fetchSavedChannelsList() async {
    await _checkBoxOpen();

    List<ChannelModel> channelModelList;
    String data;

    try {
      data = await _localStorageBox.get(_kChannelStateKey);

      final ChannelState channelState = serializers.deserializeWith(ChannelState.serializer, json.decode(data));

      channelModelList = channelState.channels.values.map((ChannelModel cm) {
        return cm.rebuild((b) => b.serverConnectStatus = ServerConnectStatus.disconnected);
      }).toList();

      // return channelModelList;
    } catch (error, stackTrace) {
      if (data != null) {
        loggerService.e(error, error.runtimeType, stackTrace);
      }

      // return default model list
      channelModelList = [
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

    return channelModelList;
  }
}
