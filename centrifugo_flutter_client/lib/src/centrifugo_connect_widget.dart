import 'package:centrifugo_flutter_client/src/utils/util.dart';
import 'package:flutter/material.dart';

import 'centrifugo_connect_bloc.dart';
import 'centrifugo_connect_status.dart';
import 'dialogs/channel_dialog.dart';
import 'dialogs/url_dialog.dart';

class CentrifugoConnectWidget extends StatefulWidget {
  const CentrifugoConnectWidget({
    Key key,
  }) : super(key: key);

  @override
  _CentrifugoConnectState createState() => _CentrifugoConnectState();
}

class _CentrifugoConnectState extends State<CentrifugoConnectWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CentrifugoConnectBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = CentrifugoConnectBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  void _connect() {
    if (!_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect data. Check "url" and "channel" fields')),
      );

      return;
    }

    _bloc.connect();
  }

  Future<void> _openUrlDialog() async {
    final String url = await showGeneralDialog<String>(
      barrierLabel: 'urlDialog',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return UrlDialogWidget();
      },
      transitionBuilder: (_, Animation<double> anim, __, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
    );

    if (url != null) {
      _bloc.centrifugoUrlTextController.text = url;
    }
  }

  Future<void> _openChannelDialog() async {
    final String url = await showGeneralDialog<String>(
      barrierLabel: 'channelDialog',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return ChannelDialogWidget();
      },
      transitionBuilder: (_, Animation<double> anim, __, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
    );

    if (url != null) {
      _bloc.centrifugoChannelTextController.text = url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<bool>(
        stream: _bloc.isInitializedStream,
        initialData: false,
        // ignore: always_specify_types
        builder: (_, isInitializedSnapshot) {
          final bool isInitialized = isInitializedSnapshot.data;

          return Stack(
            children: <Widget>[
              // content
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue.withOpacity(0.3),
                child: StreamBuilder<CentrifugoConnectStatus>(
                  stream: _bloc.centrifugoStatusSubject,
                  initialData: _bloc.currentConnectStatus,
                  // ignore: always_specify_types
                  builder: (_, snapshot) {
                    final CentrifugoConnectStatus status = snapshot.data;
                    final bool connected = status == CentrifugoConnectStatus.connected;

                    return Form(
                      key: _formKey,
                      autovalidate: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // url
                          Row(
                            children: <Widget>[
                              Container(
                                width: 100.0,
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Icon(Icons.link),
                                    Text(
                                      'Url',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _bloc.centrifugoUrlTextController,
                                  enabled: !_bloc.connectStatuses.contains(status),
                                  validator: urlFieldValidator,
                                ),
                              ),

                              // search
                              GestureDetector(
                                onTap: _bloc.connectStatuses.contains(status) ? null : () async => _openUrlDialog(),
                                child: Container(
                                  child: const Icon(
                                    Icons.search,
                                    size: 36.0,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // channel
                          Row(
                            children: <Widget>[
                              Container(
                                width: 100.0,
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Icon(Icons.chat_bubble_outline),
                                    Text(
                                      'Channel',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _bloc.centrifugoChannelTextController,
                                  enabled: !_bloc.connectStatuses.contains(status),
                                  validator: channelFieldValidator,
                                ),
                              ),

                              // search
                              GestureDetector(
                                onTap: _bloc.connectStatuses.contains(status) ? null : () async => _openChannelDialog(),
                                child: Container(
                                  child: const Icon(
                                    Icons.search,
                                    size: 36.0,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // connect
                          Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                                child: RaisedButton(
                                  onPressed: () => _connect(),
                                  child: Text(
                                    _bloc.connectStatuses.contains(status) ? 'Disconnect' : 'Connect',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                                child: Text(
                                  formatEnumToStr(status.toString()),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: connected ? Colors.green : Colors.black,
                                  ),
                                ),
                              ),
                              if (status == CentrifugoConnectStatus.connecting) const CircularProgressIndicator(),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              // loading
              if (!isInitialized)
                Container(
                  // width: double.infinity,
                  // height: double.infinity,
                  color: Colors.blue.withOpacity(0.6),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: const Text(
                            'Loading...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
