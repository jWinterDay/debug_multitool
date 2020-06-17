// import 'package:bp_template/app_keys.dart';
// import 'package:bp_template/tools/uikit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

// class MyButton extends StatelessWidget {
//   const MyButton({
//     Key key,
//     this.width,
//     @required this.callback,
//     @required this.text,
//   }) : super(key: key);

//   final double width;
//   final AsyncCallback callback;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 32),
//       width: size.width,
//       child: CupertinoButton(
//         onPressed: callback,
//         color: MyColors.red.withOpacity(0.9),
//         child: Text(
//           text,
//           key: Key(AppKeys.myMuttonText),
//           style: const TextStyle(
//             color: MyColors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
