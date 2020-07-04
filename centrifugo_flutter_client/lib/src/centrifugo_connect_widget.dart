// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:ligastavok/components/liga_app_bar.dart';
// import 'package:ligastavok/design/dimensions.dart';
// import 'package:ligastavok/feature/debug_tools/debug_tools_bloc.dart';

// import 'centrifugo_connect_status.dart';

// class DebugToolsView extends StatefulWidget {
//   DebugToolsView({
//     Key key,
//   }) : super(key: key);

//   @override
//   _DebugToolsState createState() => _DebugToolsState();
// }

// class _DebugToolsState extends State<DebugToolsView> {
//   DebugToolsBloc _bloc;

//   @override
//   void initState() {
//     super.initState();

//     _bloc = DebugToolsBloc();

//     _bloc.init().then((value) => null);
//   }

//   @override
//   void dispose() {
//     _bloc.dispose();

//     super.dispose();
//   }

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

//   // Widget _windowSizeItem(DesktopDeviceName device, String currentDevice) {
//   //   final String str = _bloc.formatEnumToStr(device.toString());
//   //   final Color color = str == currentDevice ? Colors.red[200] : Colors.grey[300];

//   //   return Container(
//   //     padding: CustomDimensions.edgeInsets8,
//   //     color: color,
//   //     // color: Colors.red.withOpacity(0.1),
//   //     child: InkWell(
//   //       onTap: () {
//   //         _bloc.setDeviceSize(device);
//   //       },
//   //       splashColor: Colors.red,
//   //       child: Text(str),
//   //     ),
//   //   );
//   // }

//   /// window size. go_flutter plugin
//   // Widget _windowSize() {
//   //   return Container(
//   //     padding: CustomDimensions.edgeInsets16,
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Container(
//   //           padding: const EdgeInsets.only(bottom: 16.0),
//   //           child: Center(
//   //             child: Text(
//   //               'window size (go_flutter)',
//   //               style: TextStyle(color: Colors.red, fontSize: 18.0),
//   //             ),
//   //           ),
//   //         ),
//   //         StreamBuilder<String>(
//   //           stream: _bloc.currentDeviceSizeStream,
//   //           builder: (context, snapshot) {
//   //             if (!snapshot.hasData) {
//   //               return Container();
//   //             }

//   //             final String currentDevice = snapshot.data;

//   //             return Wrap(
//   //               children: [
//   //                 Text('todo window size'),
//   //                 // resize
//   //                 // _windowSizeItem(DesktopDeviceName.resize, currentDevice),
//   //                 // // iphone
//   //                 // _windowSizeItem(DesktopDeviceName.iPhone5SE, currentDevice),
//   //                 // _windowSizeItem(DesktopDeviceName.iPhone8, currentDevice),
//   //                 // _windowSizeItem(DesktopDeviceName.iPhone8Plus, currentDevice),
//   //                 // _windowSizeItem(DesktopDeviceName.iPhoneX, currentDevice),
//   //                 // // android
//   //                 // _windowSizeItem(DesktopDeviceName.nexus10, currentDevice),
//   //                 // _windowSizeItem(DesktopDeviceName.pixel3, currentDevice),
//   //                 // _windowSizeItem(DesktopDeviceName.nexus5, currentDevice),
//   //               ],
//   //             );
//   //           },
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // log to file go_flutter plugin
//   // Widget _logToFile() {
//   //   return Container(
//   //       // padding: CustomDimensions.edgeInsets16,
//   //       // child: Column(
//   //       //   crossAxisAlignment: CrossAxisAlignment.start,
//   //       //   children: [
//   //       //     Container(
//   //       //       padding: const EdgeInsets.only(bottom: 16.0),
//   //       //       child: Center(
//   //       //         child: const Text(
//   //       //           'log to file (go_flutter)',
//   //       //           style: TextStyle(color: Colors.red, fontSize: 18.0),
//   //       //         ),
//   //       //       ),
//   //       //     ),
//   //       //   ],
//   //       // ),
//   //       );
//   // }

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
