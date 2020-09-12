import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_debugger/app_globals.dart';

import 'package:multi_debugger/di/app_di.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';

abstract class BaseBloc {
  AppGlobals get appGlobals => di.get<AppGlobals>();

  Stream<AppState> appStateStream;

  ChannelModel get currentChannelModel => appGlobals.store.state.channelState.currentChannel;

  @mustCallSuper
  void init() {
    appStateStream = appGlobals.store.nextSubstate((AppState state) {
      return state;
    });
  }

  @mustCallSuper
  void dispose() {}
}
