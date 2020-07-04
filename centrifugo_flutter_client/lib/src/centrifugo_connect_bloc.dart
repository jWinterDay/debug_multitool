// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:ligastavok/domain/tools.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:centrifuge/centrifuge.dart' as centrifuge;

// import 'package:ligastavok/app/globals.dart' as globals;

// import 'centrifugo_connect_status.dart';

// class DebugToolsBloc {
//   // centrifugo
//   centrifuge.Client client;
//   centrifuge.Subscription subscription;
//   StreamSubscription<centrifuge.ConnectEvent> _connectSub;
//   StreamSubscription<centrifuge.DisconnectEvent> _disconnectSub;
//   StreamSubscription<centrifuge.PublishEvent> _publishSub;

//   TextEditingController centrifugoUrlTextController = TextEditingController(text: '');
//   TextEditingController centrifugoChannelTextController = TextEditingController(text: '');
//   StreamSubscription _storeSub;

//   /// init bloc
//   Future<void> init() async {
//     // _currentDeviceSizeSubject.add(formatEnumToStr(DesktopDeviceName.resize.toString()));

//     // centrifugo url
//     String url = await _getValueFromLocalStorage('centrifugoUrl');
//     if (url == '') {
//       url = _centrifugoUrl;
//       await _setValueFromLocalStorage('centrifugoUrl', url);
//     }
//     centrifugoUrlTextController.text = url;

//     // centrifugo channel
//     String channel = await _getValueFromLocalStorage('centrifugoChannel');
//     if (channel == '') {
//       channel = _centrifugoChannel;
//       await _setValueFromLocalStorage('centrifugoChannel', channel);
//     }
//     centrifugoChannelTextController.text = channel;

//     // centrifugo status
//     _centrifugoStatusSubscription = _centrifugoStatusSubject.listen((status) {
//       globals.store.actions.config.centrifugoConnectStatus(status);
//     });

//     _centrifugoStatusSubject.add(_centrifugoStatus);
//   }

//   // centrifugo url
//   String get _centrifugoUrl {
//     return globals.store.state.configState.centrifugoUrl ??
//         'ws://172.16.55.141:8001/connection/websocket?format=protobuf';
//   }

//   // centrifugo url
//   String get _centrifugoChannel {
//     return globals.store.state.configState.centrifugoChannel ?? 'redux_store';
//   }

//   // centrifugo status
//   CentrifugoConnectStatus get _centrifugoStatus {
//     return globals.store.state.configState.centrifugoConnectStatus ?? CentrifugoConnectStatus.disconnected;
//   }

//   // status
//   final BehaviorSubject<CentrifugoConnectStatus> _centrifugoStatusSubject = BehaviorSubject<CentrifugoConnectStatus>();
//   StreamSubscription<CentrifugoConnectStatus> _centrifugoStatusSubscription;

//   final BehaviorSubject<String> _currentDeviceSizeSubject = BehaviorSubject<String>();
//   Stream<String> get currentDeviceSizeStream => _currentDeviceSizeSubject.stream;

//   Stream<CentrifugoConnectStatus> get centrifugoStatusStream {
//     return _centrifugoStatusSubject.stream;
//   }

//   CentrifugoConnectStatus get centrifugoStatusInit {
//     return CentrifugoConnectStatus.disconnected;
//   }

//   String formatEnumToStr(String enumString) {
//     return enumString.split('.')[1];
//   }

//   /// local storage
//   Future<String> _getValueFromLocalStorage(String key) async {
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       return preferences.getString(key) ?? '';
//     } catch (exc) {
//       logger.e('SharedPreferences exc: $exc');
//     }

//     return '';
//   }

//   Future<void> _setValueFromLocalStorage(String key, String val) async {
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       await preferences.setString(key, val);
//     } catch (exc) {
//       logger.e('SharedPreferences exc: $exc');
//     }
//   }

//   /// ws connect
//   Future<void> connectToCentrifugo() async {
//     if (_centrifugoStatusSubject.value == CentrifugoConnectStatus.connected) {
//       _centrifugoStatusSubject.add(CentrifugoConnectStatus.disconnected);

//       client?.disconnect();

//       Future<void>.delayed(const Duration(milliseconds: 200), () {
//         _connectSub?.cancel();
//         _disconnectSub?.cancel();
//         _publishSub?.cancel();
//       });

//       subscription?.unsubscribe();
//       client = null;

//       return;
//     }

//     _centrifugoStatusSubject.add(CentrifugoConnectStatus.connecting);
//     final String currentTextUrl = centrifugoUrlTextController.text;
//     await _setValueFromLocalStorage('centrifugoUrl', currentTextUrl);

//     final String currentTextChannel = centrifugoChannelTextController.text;
//     await _setValueFromLocalStorage('centrifugoChannel', currentTextChannel);

//     globals.store.actions.config.centrifugoUrl(currentTextUrl);
//     globals.store.actions.config.centrifugoChannel(currentTextChannel);

//     client = centrifuge.createClient(currentTextUrl);
//     subscription = client.getSubscription(currentTextChannel);

//     // connect sub
//     _connectSub = client.connectStream.listen((centrifuge.ConnectEvent event) {
//       _centrifugoStatusSubject.add(CentrifugoConnectStatus.connected);
//     });
//     // disconnect sub
//     _disconnectSub = client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
//       _centrifugoStatusSubject.add(CentrifugoConnectStatus.disconnected);
//     });
//     // publish sub
//     _publishSub = subscription.publishStream.listen((centrifuge.PublishEvent event) {
//       // final dynamic message = json.decode(utf8.decode(event.data));
//     });

//     subscription.subscribe();
//     client.connect();

//     // send redux state
//     _storeSub = globals.store.stream.listen((storeChange) {
//       final actionName = storeChange.action.name;
//       final payload = storeChange.action.payload;
//       final state = globals.store?.state?.eventListState?.events?.values?.toString() ??
//           'empty'; //?.replaceAll('\n', '')?.replaceAll(' ', '') ?? 'empty';
//       // .replaceAll('"EventListState ', '')
//       // .replaceAll('"', '');
//       // sportBookState?.categories?.map((e) => e.id) ?? 'empty';

//       // print('-----store: $actionName');

//       final output = jsonEncode({
//         'action': actionName.toString(),
//         'payload': payload.toString(),
//         'state': state.toString(),
//       });
//       final data = utf8.encode(output);

//       try {
//         subscription?.publish(data);
//       } catch (exc) {
//         logger.e('[centrifugo] exc = $exc');
//       }
//     });
//   }

//   /// open browser
//   Future<void> openBrowser() async {
//     // final url = 'http:${centrifugoUrlTextController.text}';

//     // bool canCall = await url_launcher.canLaunch(url);
//     // if (canCall) {
//     //   await url_launcher.launch(url);
//     // }
//   }

//   // Future<void> setDeviceSize(DesktopDeviceName device) async {
//   //   try {
//   //     await DesktopUtils.setDevice(device);
//   //     _currentDeviceSizeSubject.add(formatEnumToStr(device.toString()));
//   //   } catch (exc) {
//   //     logger.e('setDeviceSize exc: $exc');
//   //   }
//   // }

//   /// dont close subscriptions in dispose
//   /// need to transmit data in background
//   void stopListeningCentrifugo() {
//     _storeSub?.cancel();
//     _connectSub?.cancel();
//     _disconnectSub?.cancel();
//     _publishSub?.cancel();
//     _centrifugoStatusSubscription?.cancel();
//     _centrifugoStatusSubject.close();
//   }

//   void dispose() {
//     // _centrifugoStatusSubject.close();
//     _currentDeviceSizeSubject.close();

//     // text controller
//     centrifugoUrlTextController.dispose();
//     centrifugoChannelTextController.dispose();
//   }
// }
