// import 'package:bp_template/tools/uikit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flushbar/flushbar.dart';

// class Snackbar {
//   Flushbar _current;

//   Future hide() => _current?.dismiss();

//   show({BuildContext context, String title, String text}) {
//     hide();

//     _current = Flushbar(
//       flushbarPosition: FlushbarPosition.BOTTOM,
//       flushbarStyle: FlushbarStyle.FLOATING,
//       backgroundColor: MyColors.primary.withOpacity(0.8),
//       // backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.red]),
//       isDismissible: false,
//       duration: Duration(seconds: 4),
//       icon: Icon(
//         CupertinoIcons.info,
//         size: 34.0,
//         color: MyColors.white,
//       ),
//       progressIndicatorBackgroundColor: MyColors.gray_666666,
//       messageText: Text(
//         text ?? '',
//         style: const TextStyle(
//           fontSize: 18.0,
//           color: MyColors.gray_e5e5e5,
//         ),
//       ),
//     );

//     _current.show(context);
//   }
// }
