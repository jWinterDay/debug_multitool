import 'package:centrifugo_flutter_client/src/utils/util.dart';
import 'package:flutter/material.dart';

import 'centrifugo_connect_bloc.dart';
import 'centrifugo_connect_status.dart';
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

    // _bloc.init().then((value) => null);
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

    //
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.blue.withOpacity(0.3),
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<bool>(
          stream: _bloc.isInitializedStream,
          initialData: false,
          // ignore: always_specify_types
          builder: (_, isInitializedSnapshot) {
            final bool isInitialized = isInitializedSnapshot.data;

            if (!isInitialized) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const CircularProgressIndicator(),
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
              );
            }

            return StreamBuilder<CentrifugoConnectStatus>(
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
                              validator: urlFieldValidator,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final String url = await showGeneralDialog<String>(
                                barrierLabel: 'urlDialog',
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.5),
                                transitionDuration: const Duration(milliseconds: 300),
                                context: context,
                                pageBuilder: (_, __, ___) {
                                  return const UrlDialogWidget();
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
                              //
                              print('url = $url');
                            },
                            child: Container(
                              child: const Icon(Icons.search),
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
                              validator: channelFieldValidator,
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
                              onPressed: connected ? null : () => _connect(),
                              child: const Text('Connect'),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                            child: Text(
                              formatEnumToStr(status.toString()),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
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
            );
          },
        ),
      ),
    );
  }
}
