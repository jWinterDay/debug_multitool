import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multi_debugger/app_routes.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/models/saved_url.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

class SelectUrlBloc extends BaseBloc {
  StreamSubscription<SavedUrlState> _savedUrlStateSubscription;

  BehaviorSubject<SavedUrlState> _savedUrlStateSubject;
  SavedUrlState get initSavedUrlState => appGlobals.store.state.savedUrlState;
  Stream<SavedUrlState> get savedUrlStateStream => _savedUrlStateSubject.stream;

  @override
  void dispose() {
    _savedUrlStateSubscription?.cancel();
    _savedUrlStateSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _savedUrlStateSubject = BehaviorSubject<SavedUrlState>();

    _savedUrlStateSubscription = appGlobals.store.nextSubstate((AppState state) {
      return state;
    }).map((AppState state) {
      return state.savedUrlState;
    }).listen((SavedUrlState state) {
      _savedUrlStateSubject.add(state);
    });
  }

  List<SavedUrl> filterSavedUrl(SavedUrlState state, {bool custom = true}) {
    return state.urls.values.where((SavedUrl savedUrl) {
      return savedUrl.custom == custom;
    }).toList();
  }

  void pop(BuildContext ctx, String selectedUrl) {
    // set url to current channel model
    final ChannelModel curChannelModel = appGlobals.store.state.channelState.currentChannel;
    final ChannelModel nextChannelModel = ChannelModel((b) {
      b
        ..replace(curChannelModel)
        ..wsUrl = selectedUrl;
      return b;
    });
    appGlobals.store.actions.channelActions.updateChannel(nextChannelModel);

    // pop
    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.pop
        ..context = ctx),
    );
  }

  // add new custom url (TEST)
  void selectUrl(String urlId) {
    // SavedUrl savedUrl = SavedUrl((b) => b..url = url);

    // appGlobals.store.actions.savedUrlActions.addUrl(savedUrl);
  }

  // add new custom url (TEST)
  void addUrl(String url) {
    SavedUrl savedUrl = SavedUrl((b) => b..url = url);

    appGlobals.store.actions.savedUrlActions.addUrl(savedUrl);
  }
  // void showSelectUrl(BuildContext context) {
  //   appGlobals.store.actions.routeTo(
  //     AppRoute((builder) => builder
  //       ..route = AppRoutes.selectUrl
  //       ..context = context),
  //   );
  // }
}
