import 'dart:async';

import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/enums/filter_list_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/states.dart';
import 'package:rxdart/rxdart.dart';

class FilterListBloc extends BaseBloc {
  BehaviorSubject<ChannelModel> _currentChannelModelSubject;
  Stream<ChannelModel> get currentChannelModelStream => _currentChannelModelSubject.stream;
  StreamSubscription<ChannelState> _channelStateSubscription;

  @override
  void dispose() {
    _channelStateSubscription?.cancel();
    _currentChannelModelSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    _currentChannelModelSubject = BehaviorSubject<ChannelModel>();

    _channelStateSubscription = appStateStream.map((AppState state) {
      return state.channelState;
    }).listen((ChannelState state) {
      _currentChannelModelSubject.add(state.currentChannel);
    });
  }

  /// delete filter item
  void deleteItem(FilterListType filterListType, String filter) {
    Pair<ChannelModel, String> pair = Pair(currentChannelModel, filter);

    switch (filterListType) {
      case FilterListType.white:
        appGlobals.store.actions.channelActions.deleteWhiteListItem(pair);
        break;
      case FilterListType.black:
        appGlobals.store.actions.channelActions.deleteBlackListItem(pair);
        break;
      default:
    }
  }
}
