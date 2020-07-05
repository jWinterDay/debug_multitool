import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:centrifugo_flutter_client/src/models/app_state.dart';
import 'package:centrifugo_flutter_client/src/models/channel.dart';
import 'package:centrifugo_flutter_client/src/models/used_url.dart';
import 'package:centrifugo_flutter_client/src/utils/hive_boxes.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:centrifuge/centrifuge.dart' as centrifuge;

import 'centrifugo_connect_status.dart';

// ws://172.16.55.141:8001/connection/websocket?format=protobuf
class CentrifugoConnectBloc {
  CentrifugoConnectBloc() {
    _isInitialized = BehaviorSubject<bool>.seeded(false);

    centrifugoUrlTextController = TextEditingController(text: '');
    centrifugoChannelTextController = TextEditingController(text: '');

    _centrifugoStatusSubject = BehaviorSubject<CentrifugoConnectStatus>.seeded(CentrifugoConnectStatus.disconnected);
    _formCorrectSubject = BehaviorSubject<bool>.seeded(false);

    init().then((_) {
      _isInitialized.add(true);
    });
  }

  Box<AppState> _appStateBox;
  Box<UsedUrl> _usedUrlBox;
  Box<Channel> _channelBox;

  // all parts is bloc initialized
  BehaviorSubject<bool> _isInitialized;
  Stream<bool> get isInitializedStream => _isInitialized.stream;
  //

  centrifuge.Client client;
  centrifuge.Subscription subscription;
  StreamSubscription<centrifuge.ConnectEvent> _connectSub;
  StreamSubscription<centrifuge.DisconnectEvent> _disconnectSub;
  StreamSubscription<centrifuge.PublishEvent> _publishSub;

  TextEditingController centrifugoUrlTextController;
  TextEditingController centrifugoChannelTextController;

  // status
  BehaviorSubject<CentrifugoConnectStatus> _centrifugoStatusSubject;
  StreamSubscription<CentrifugoConnectStatus> _centrifugoStatusSubscription;
  Stream<CentrifugoConnectStatus> get centrifugoStatusSubject => _centrifugoStatusSubject.stream;
  CentrifugoConnectStatus get currentConnectStatus => _centrifugoStatusSubject.value;

  // publish
  BehaviorSubject<String> _publishSubject;

  // ui fields
  BehaviorSubject<bool> _formCorrectSubject;
  Stream<bool> get formCorrectStream => _formCorrectSubject.stream;

  /// init bloc
  Future<void> init() async {
    // hive adapter
    Hive.registerAdapter<UsedUrl>(UsedUrlAdapter());
    Hive.registerAdapter<Channel>(ChannelAdapter());
    Hive.registerAdapter<AppState>(AppStateAdapter());

    // hive init
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    // getTemporaryDirectory();
    debugPrint('hive path: ${appDocDir.path}');
    Hive.init(appDocDir.path);

    _appStateBox = await Hive.openBox<AppState>(HiveBoxes.appState);
    _usedUrlBox = await Hive.openBox<UsedUrl>(HiveBoxes.usedUrl);
    _channelBox = await Hive.openBox<Channel>(HiveBoxes.channel);

    // last url and channel
    final AppState appState = _appStateBox.get(0);
    centrifugoUrlTextController.text = appState?.currentUrl ?? '';
    centrifugoChannelTextController.text = appState?.currentChannel ?? '';

    // persistent data
  }

  /// send data to centrifugo server
  /// example:
  /// ```json
  /// action: action1
  /// payload: {
  ///   "name1":"name1",
  ///   "name1":"name1"
  /// },
  /// state: state
  /// ```
  Future<void> sendData({String action, Object payload, Object state}) async {
    if (currentConnectStatus != CentrifugoConnectStatus.connected) {
      return;
    }

    try {
      final String output = jsonEncode(<String, dynamic>{
        'action': action,
        'payload': payload.toString(),
        'state': state.toString(),
      });

      final List<int> data = utf8.encode(output);

      await subscription?.publish(data);
    } catch (exc) {
      debugPrint('[centrifugo] send data exc: $exc');
    }
  }

  Future<void> _connect() async {
    _centrifugoStatusSubject.add(CentrifugoConnectStatus.connecting);

    // url
    final String url = centrifugoUrlTextController.text;
    // ignore: unawaited_futures
    _saveUsedUrl(url);

    // channel
    final String channel = centrifugoChannelTextController.text;
    // ignore: unawaited_futures
    _saveChannel(channel);

    // connect
    client = centrifuge.createClient(url);
    subscription = client.getSubscription(channel);

    // subscriptions
    _connectSub = client.connectStream.listen((centrifuge.ConnectEvent event) {
      _centrifugoStatusSubject.add(CentrifugoConnectStatus.connected);
    });
    // disconnect sub
    _disconnectSub = client.disconnectStream.listen((centrifuge.DisconnectEvent event) {
      _centrifugoStatusSubject.add(CentrifugoConnectStatus.disconnected);
    });
    // publish sub
    _publishSub = subscription.publishStream.listen((centrifuge.PublishEvent event) {
      final dynamic message = json.decode(utf8.decode(event.data));
      _publishSubject.add(message.toString());
    });

    subscription.subscribe();
    client.connect();
  }

  Future<void> _disconnect() async {
    if (currentConnectStatus == CentrifugoConnectStatus.connected) {
      client?.disconnect();
    }

    _centrifugoStatusSubject.add(CentrifugoConnectStatus.disconnected);

    Future<void>.delayed(const Duration(milliseconds: 200), () {
      _connectSub?.cancel();
      _disconnectSub?.cancel();
      _publishSub?.cancel();
    });

    subscription?.unsubscribe();
    client = null;
  }

  /// ws connect
  final List<CentrifugoConnectStatus> connectStatuses = <CentrifugoConnectStatus>[
    CentrifugoConnectStatus.connecting,
    CentrifugoConnectStatus.connected,
  ];

  Future<void> _saveUsedUrl(String url) async {
    // add to url list
    final int key = await _usedUrlBox.add(UsedUrl(
      name: url,
      isPermanent: true,
    ));
    debugPrint('key: $key');

    // update state
    if (_appStateBox.isEmpty) {
      await _appStateBox.add(
        AppState(currentUrl: url),
      );
    } else {
      final AppState appState = _appStateBox.getAt(0);
      appState.currentUrl = url;
      await appState.save();
    }
  }

  Future<void> _saveChannel(String channel) async {
    final int key = await _channelBox.add(Channel(
      name: channel,
    ));
    debugPrint('key: $key');

    // update state
    if (_appStateBox.isEmpty) {
      await _appStateBox.add(AppState(
        currentChannel: channel,
      ));
    } else {
      final AppState appState = _appStateBox.getAt(0);
      appState.currentChannel = channel;
      await appState.save();
    }
  }

  Future<void> connect() async {
    if (connectStatuses.contains(currentConnectStatus)) {
      await _disconnect();
      return;
    }

    await _connect();
  }

  /// dont close subscriptions in dispose
  /// need for transmitting data in background
  void unsubscribe() {
    _connectSub?.cancel();
    _disconnectSub?.cancel();
    _publishSub?.cancel();
    _centrifugoStatusSubscription?.cancel();
    _centrifugoStatusSubject.close();
    _publishSubject.close();
  }

  void dispose() {
    _isInitialized.close();

    // _usedUrlBox.compact();
    _usedUrlBox.close();
    _channelBox.close();
    _appStateBox.close();
    Hive.close();

    centrifugoUrlTextController.dispose();
    centrifugoChannelTextController.dispose();
    _formCorrectSubject.close();
  }
}
