import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/subjects.dart';

class TabBarBloc extends BaseBloc {
  StreamSubscription<ChannelModel> _currentChannelModelSubscription;
  ChannelModel get currentChannelModel => appGlobals.store.state.channelState.currentChannel;
  BehaviorSubject<ChannelModel> _currentChannelModelSubject;
  Stream<ChannelModel> get currentChannelModelStream => _currentChannelModelSubject.stream;

  final TextEditingController urlTextController = TextEditingController(text: '');
  BehaviorSubject<String> _urlSubject;

  BehaviorSubject<bool> _correctSubject;
  Stream<bool> get correctStream => _correctSubject.stream;

  @override
  void dispose() {
    _currentChannelModelSubscription?.cancel();

    _currentChannelModelSubject.close();
    _urlSubject.close();
    _correctSubject.close();

    urlTextController.dispose();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    // url text controller
    urlTextController.addListener(() {
      final String url = urlTextController.text;

      _urlSubject.add(url);

      // correct
      final bool correct = url.isNotEmpty;
      _correctSubject.add(correct);

      // save url for current channel
      if (currentChannelModel != null) {
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
    _urlSubject = BehaviorSubject<String>.seeded('');
    _correctSubject = BehaviorSubject<bool>.seeded(false);

    // state
    _currentChannelModelSubscription = appGlobals.store.nextSubstate((AppState state) {
      return state;
    }).map((state) {
      return state.channelState.currentChannel;
    }).listen((ChannelModel channelModel) {
      _currentChannelModelSubject.add(channelModel);

      urlTextController.text = channelModel?.wsUrl ?? '';
    });
  }

  void onUrlChanged(String url) => _urlSubject.add(url);

  void showSelectUrl() {
    //
  }

  void connect() {
    // appGlobals.store.actions.channelActions.//.state.channelState.currentChannel.
    //
  }

  // void showAddChannel(BuildContext context) {
  //   appGlobals.store.actions.routeTo(
  //     AppRoute((builder) => builder
  //       ..route = AppRoutes.editChannel
  //       ..context = context),
  //   );
  // }

  // void setCurrent(ChannelModel channelModel) {
  //   appGlobals.store.actions.channelActions.setCurrentChannel(channelModel);
  //   // appGlobals.store.actions.routeTo(
  //   //   AppRoute((builder) => builder
  //   //     ..route = AppRoutes.editChannel
  //   //     ..context = context
  //   //     ..bundle = channelModel),
  //   // );
  // }
}
