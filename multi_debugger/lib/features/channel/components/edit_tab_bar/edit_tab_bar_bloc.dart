import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_debugger/app_routes.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

class EditTabBarBloc extends BaseBloc {
  StreamSubscription<AppConfigState> _computerNameSubscription;
  StreamSubscription<bool> _correctFormSubscription;

  BehaviorSubject<String> _computerNameSubject;
  String get initComputerName => appGlobals.store.state.appConfigState.computerName;
  Stream<String> get computerNameStream => _computerNameSubject.stream;

  BehaviorSubject<String> _nameSubject;
  BehaviorSubject<String> _shortNameSubject;
  BehaviorSubject<bool> _correctFormSubject;
  Stream<bool> get correctFormStream => _correctFormSubject.stream;

  @override
  void dispose() {
    _computerNameSubscription?.cancel();
    _correctFormSubscription?.cancel();

    _computerNameSubject.close();
    _nameSubject.close();
    _shortNameSubject.close();
    _correctFormSubject.close();

    super.dispose();
  }

  void toggleInitialValues({@required String name, @required String shortName}) {
    _nameSubject.add(name);
    _shortNameSubject.add(shortName);
  }

  @override
  void init() {
    super.init();

    _nameSubject = BehaviorSubject<String>.seeded('');
    _shortNameSubject = BehaviorSubject<String>.seeded('');
    _correctFormSubject = BehaviorSubject<bool>.seeded(false);

    _correctFormSubscription = Rx.combineLatest2<String, String, bool>(_nameSubject, _shortNameSubject, (
      String name,
      String shortName,
    ) {
      if (name.isEmpty || shortName.isEmpty) {
        return false;
      }

      if (name.length > 15 || shortName.length > 15) {
        return false;
      }

      return true;
    }).listen((bool correct) {
      _correctFormSubject.add(correct);
    });

    _computerNameSubject = BehaviorSubject<String>();

    _computerNameSubscription = appStateStream.map((AppState state) {
      return state.appConfigState;
    }).listen((AppConfigState state) {
      _computerNameSubject.add(state.computerName);
    });
  }

  void pop(BuildContext context) {
    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.pop
        ..context = context),
    );
  }

  void onNameChanged(String name) {
    _nameSubject.add(name);
  }

  void onShortNameChanged(String name) {
    _shortNameSubject.add(name);
  }

  void addChannel() {
    final String name = _nameSubject.value;
    final String shortName = _shortNameSubject.value;

    // validate
    final bool correct = name.isNotEmpty && shortName.isNotEmpty;
    if (!correct) {
      return;
    }

    ChannelModel channelModel = ChannelModel((b) {
      return b
        ..name = name
        ..serverConnectStatus = ServerConnectStatus.disconnected
        ..isCurrent = true
        ..shortName = shortName;
    });

    appGlobals.store.actions.channelActions.addChannel(channelModel);
  }

  void updateChannel(ChannelModel channelModel) {
    final String name = _nameSubject.value;
    final String shortName = _shortNameSubject.value;

    ChannelModel nextChannelModel = ChannelModel((b) {
      b
        ..replace(channelModel)
        ..name = name
        ..shortName = shortName;

      return b;
    });

    appGlobals.store.actions.channelActions.updateChannel(nextChannelModel);
  }
}
