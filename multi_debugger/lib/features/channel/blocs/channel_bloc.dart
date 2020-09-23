import 'package:multi_debugger/domain/base/base_bloc.dart';

class ChannelBloc extends BaseBloc {
  // BehaviorSubject<PlatformEventState> _platformStateSubject;
  // StreamSubscription<PlatformEventState> _platformStateSubscription;
  // Stream<PlatformEvent> get platformEventStream {
  //   return _platformStateSubject
  //       .map((PlatformEventState state) => state.platformEvent)
  //       .debounceTime(const Duration(milliseconds: 100));
  // }

  // PlatformEvent get currentPlatformEvent => _platformStateSubject.value.platformEvent;

  @override
  void dispose() {
    // _platformStateSubscription?.cancel();
    // _platformStateSubject.close();

    super.dispose();
  }

  @override
  void init() {
    super.init();

    // _platformStateSubject = BehaviorSubject<PlatformEventState>();

    // _platformStateSubscription = appStateStream.map((AppState state) {
    //   return state.platformEventState;
    // }).where((PlatformEventState state) {
    //   return state.platformEvent.type == PlatformEventType.resize;
    // }).listen((PlatformEventState state) {
    //   // print('------${state.platformEvent}');
    //   _platformStateSubject.add(state);
    // });
  }
}
