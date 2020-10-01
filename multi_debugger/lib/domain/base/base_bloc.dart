import 'package:flutter/material.dart';
import 'package:multi_debugger/app_globals.dart';

import 'package:multi_debugger/di/app_di.dart';
import 'package:multi_debugger/domain/models/models.dart';

abstract class BaseBloc {
  AppGlobals get appGlobals => di.get<AppGlobals>();

  ChannelModel get currentChannelModel => appGlobals.store.state.channelState.currentChannel;

  String get computerName => appGlobals.store.state.appConfigState.computerName ?? '';

  @mustCallSuper
  void init() {}

  @mustCallSuper
  void dispose() {}
}
