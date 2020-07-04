import 'package:centrifugo_flutter_client/src/utils/util.dart';
import 'package:flutter/material.dart';

import 'centrifugo_connect_bloc.dart';
import 'centrifugo_connect_status.dart';

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
                          validator: urlFieldValidator,
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

            //             return Column(
            //   children: [
            //     Container(
            //       // padding: CustomDimensions.edgeInsetsHorizontal4,
            //       child:   CupertinoTextField(
            //         readOnly: true,
            //         controller: _bloc.centrifugoUrlTextController,
            //         padding: CustomDimensions.edgeInsets8,
            //         placeholder: 'ws://172.16.55.141:8001/connection/websocket?format=protobuf',
            //         cursorColor: Colors.blue,
            //         decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
            //       ),
            //     ),
            //     Container(
            //       padding: CustomDimensions.edgeInsetsHorizontal4,
            //       child: CupertinoTextField(
            //         readOnly: status == CentrifugoConnectStatus.connected,
            //         controller: _bloc.centrifugoChannelTextController,
            //         padding: CustomDimensions.edgeInsets8,
            //         placeholder: 'centrifugo channel',
            //         cursorColor: Colors.blue,
            //         clearButtonMode: OverlayVisibilityMode.always,
            //         // decoration: status == CentrifugoConnectStatus.connected
            //         //     ? BoxDecoration(color: Colors.grey.withOpacity(0.2))
            //         //     : BoxDecoration(color: Colors.white),
            //       ),
            //     ),
            //   ],
            // );

            // return Text('fds');
          },
        ),
      ),
    );
  }
}

//   Widget _header() {
//     return SliverList(
//       delegate: SliverChildListDelegate(
//         [
//           DefaultTabBar(
//             backgroundColor: Colors.white,
//             middle: Text(
//               'Debug tools(only debug mode)',
//             ),
//             useDefaultLeading: false,
//             useDefaultTrailing: false,
//           ),
//           Container(
//             height: 1.0,
//             color: Colors.black.withOpacity(0.12),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _content() {
//     return SliverToBoxAdapter(
//       child: Container(
//         padding: const EdgeInsets.only(top: 8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // redux remote
//             Container(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: Center(
//                 child: const Text(
//                   'centrifugo',
//                   style: TextStyle(color: Colors.red, fontSize: 18.0),
//                 ),
//               ),
//             ),
//             StreamBuilder<CentrifugoConnectStatus>(
//               stream: _bloc.centrifugoStatusStream,
//               initialData: _bloc.centrifugoStatusInit,
//               builder: (_, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Container();
//                 }

//                 final CentrifugoConnectStatus status = snapshot.data;

//                 return Column(
//                   children: [
//                     Container(
//                       padding: CustomDimensions.edgeInsetsHorizontal4,
//                       child: CupertinoTextField(
//                         readOnly: true,
//                         controller: _bloc.centrifugoUrlTextController,
//                         padding: CustomDimensions.edgeInsets8,
//                         placeholder: 'ws://172.16.55.141:8001/connection/websocket?format=protobuf',
//                         cursorColor: Colors.blue,
//                         decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
//                       ),
//                     ),
//                     Container(
//                       padding: CustomDimensions.edgeInsetsHorizontal4,
//                       child: CupertinoTextField(
//                         readOnly: status == CentrifugoConnectStatus.connected,
//                         controller: _bloc.centrifugoChannelTextController,
//                         padding: CustomDimensions.edgeInsets8,
//                         placeholder: 'centrifugo channel',
//                         cursorColor: Colors.blue,
//                         clearButtonMode: OverlayVisibilityMode.always,
//                         // decoration: status == CentrifugoConnectStatus.connected
//                         //     ? BoxDecoration(color: Colors.grey.withOpacity(0.2))
//                         //     : BoxDecoration(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),

//             StreamBuilder<CentrifugoConnectStatus>(
//               stream: _bloc.centrifugoStatusStream,
//               initialData: _bloc.centrifugoStatusInit,
//               builder: (_, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Container();
//                 }

//                 final CentrifugoConnectStatus status = snapshot.data;

//                 final str = status.toString().split('.')[1];

//                 return Container(
//                   padding: CustomDimensions.edgeInsets8,
//                   color: Colors.grey[300],
//                   child: Row(
//                     children: [
//                       InkWell(
//                         splashColor: Colors.red,
//                         child: Row(
//                           children: [
//                             // const Text(
//                             //   'Connect',
//                             //   style: TextStyle(
//                             //     color: Colors.black,
//                             //     fontSize: 18,
//                             //   ),
//                             // ),
//                             Icon(
//                               (status == CentrifugoConnectStatus.connected)
//                                   ? CupertinoIcons.pause
//                                   : CupertinoIcons.play_arrow,
//                               color: Colors.red,
//                               size: 40,
//                             ),
//                           ],
//                         ),
//                         onTap: () async {
//                           await _bloc.connectToCentrifugo();
//                         },
//                       ),
//                       Text(
//                         'status: $str',
//                         style: TextStyle(
//                           color: status == CentrifugoConnectStatus.connected ? Colors.green : Colors.grey,
//                           fontSize: 18,
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),

//             // window size
//             // _windowSize(),

//             // // log to file
//             // _logToFile(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(
//         topLeft: CustomDimensions.r12,
//         topRight: CustomDimensions.r12,
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Scaffold(
//           resizeToAvoidBottomInset: true,
//           body: CustomScrollView(
//             // shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             slivers: [
//               _header(),
//               _content(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
