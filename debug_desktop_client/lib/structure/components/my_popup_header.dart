// import 'package:bp_template/tools/uikit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

// class MyPopupHeader extends StatelessWidget {
//   const MyPopupHeader({
//     this.title,
//     this.callback,
//   }) : assert(title != null);

//   final String title;
//   final AsyncCallback callback;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: MyColors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16),
//                   ),
//                 ),
//                 child: Stack(
//                   children: <Widget>[
//                     Center(
//                       child: Container(
//                         child: Text(
//                           title,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       right: 16,
//                       top: 12,
//                       child: GestureDetector(
//                         onTap: () => callback == null ? null : callback(),
//                         child: Container(
//                           height: 32,
//                           width: 48,
//                           color: MyColors.transparent,
//                           child: Icon(CupertinoIcons.clear),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Container(
//           height: 1,
//           color: MyColors.gray_cccccc,
//         ),
//       ],
//     );
//   }
// }
