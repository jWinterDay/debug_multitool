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

const String _kChannelStateName = 'channelState';
const String _kChannelStateKey = 'state';

class LocalStorageServiceImpl extends LocalStorageService {
  LocalStorageServiceImpl({
    @required this.loggerService,
  }) : assert(loggerService != null);
  final LoggerService loggerService;

  Box<String> _channelStateBox;

  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    _channelStateBox.close();

    super.dispose();
  }

  @override
  Future<void> initStorage() async {
    final Directory appDocumentDirectory =
        await path_provider.getDownloadsDirectory(); // getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
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
  Future<void> saveChannelState(ChannelState channelState) async {
    final bool open = _channelStateBox?.isOpen ?? false;

    if (!open) {
      _channelStateBox = await Hive.openBox<String>(_kChannelStateName);
    }

    try {
      final String channelStateStr = json.encode(serializers.serialize(channelState));

      await _channelStateBox.put(_kChannelStateKey, channelStateStr);
    } catch (error, stackTrace) {
      loggerService.e(error, error.runtimeType, stackTrace);
    }
  }

  @override
  Future<List<ChannelModel>> fetchSavedChannelsList() async {
    final bool open = _channelStateBox?.isOpen ?? false;

    if (!open) {
      _channelStateBox = await Hive.openBox<String>(_kChannelStateName);
    }

    try {
      final String data = await _channelStateBox.get(_kChannelStateKey);

      final ChannelState channelState = serializers.deserializeWith(ChannelState.serializer, json.decode(data));

      List<ChannelModel> fmtChannelModelList = channelState.channels.values.map((ChannelModel cm) {
        return cm.rebuild((b) => b.serverConnectStatus = ServerConnectStatus.disconnected);
      }).toList();

      return fmtChannelModelList;
    } catch (error, stackTrace) {
      loggerService.e(error, error.runtimeType, stackTrace);
    }

    // return default model list
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
