import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multi_debugger/app_routes.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:rxdart/subjects.dart';

class TabBarBloc extends BaseBloc {
  StreamSubscription<ChannelModel> _currentChannelModelSubscription;
  BehaviorSubject<ChannelModel> _currentChannelModelSubject;
  Stream<ChannelModel> get currentChannelModelStream => _currentChannelModelSubject.stream;

  final TextEditingController urlTextController = TextEditingController(text: '');

  BehaviorSubject<bool> _enabledConnectBtnSubject;
  Stream<bool> get enabledConnectBtnStream => _enabledConnectBtnSubject.stream;

  @override
  void dispose() {
    _currentChannelModelSubscription?.cancel();

    _currentChannelModelSubject.close();
    _enabledConnectBtnSubject.close();

    urlTextController.dispose();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    // url text controller
    urlTextController.addListener(() {
      final String url = urlTextController.text;

      // correct
      final bool correct = url.isNotEmpty;

      // connect status
      // final bool enabledByStatus = currentChannelModel.serverConnectStatus == Server

      _enabledConnectBtnSubject.add(correct);

      // save url for current channel
      if (currentChannelModel != null && url != currentChannelModel?.wsUrl) {
        ChannelModel nextChannelModel = ChannelModel((b) {
          b
            ..replace(currentChannelModel)
            ..wsUrl = url;

          return b;
        });

        appGlobals.store.actions.channelActions.updateChannel(nextChannelModel);
      }
    });

    _currentChannelModelSubject = BehaviorSubject<ChannelModel>();
    _enabledConnectBtnSubject = BehaviorSubject<bool>.seeded(false);

    // state
    _currentChannelModelSubscription = appGlobals.store.nextSubstate((state) {
      return state.channelState.currentChannel;
    }).listen((ChannelModel channelModel) {
      if (channelModel?.wsUrl != urlTextController.text) {
        urlTextController.text = channelModel?.wsUrl ?? '';
      }

      _currentChannelModelSubject.add(channelModel);
    });
  }

  void showSelectUrl(BuildContext context) {
    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.selectUrl
        ..context = context),
    );
  }

  void showChannelActions(BuildContext context) {
    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.showChannelActions
        ..bundle = currentChannelModel
        ..context = context),
    );
  }

  void connect() {
    if (currentChannelModel == null) {
      return;
    }

    final ServerConnectStatus curStatus = currentChannelModel.serverConnectStatus;

    ServerConnectStatus resStatus;

    switch (curStatus) {
      case ServerConnectStatus.disconnected:
        resStatus = ServerConnectStatus.connecting;
        break;
      case ServerConnectStatus.connecting:
      case ServerConnectStatus.connected:
        resStatus = ServerConnectStatus.disconnected;
        break;
      default:
    }

    Pair<ChannelModel, ServerConnectStatus> pair = Pair(currentChannelModel, resStatus);

    appGlobals.store.actions.channelActions.changeConnectStatus(pair);
  }
}
