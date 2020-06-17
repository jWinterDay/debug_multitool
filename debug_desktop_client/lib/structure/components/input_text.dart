// import 'package:bp_template/tools/uikit.dart';
// import 'package:flutter/cupertino.dart';

// class InputText extends StatefulWidget {
//   InputText({
//     @required this.context,
//     this.placeholder,
//     this.controller,
//     this.inputType,
//     this.enabled = true,
//     this.focusNode,
//     this.focused = false,
//     this.bgColor = MyColors.white,
//     this.isWarning = false,
//     this.padding,
//   })  : assert(context != null),
//         // assert(controller != null),
//         assert(enabled != null),
//         assert(focused != null);

//   final BuildContext context;
//   final String placeholder;
//   final TextEditingController controller;
//   final TextInputType inputType;
//   final bool enabled;
//   final FocusNode focusNode;
//   final bool focused;
//   final Color bgColor;
//   final bool isWarning;
//   final EdgeInsets padding;

//   @override
//   _InputTextState createState() => _InputTextState();
// }

// class _InputTextState extends State<InputText> {
//   FocusNode _focusNode;

//   @override
//   void initState() {
//     super.initState();

//     _focusNode = widget.focusNode == null
//         ? FocusNode(canRequestFocus: true)
//         : widget.focusNode;

//     _focusNode.addListener(() {
//       if (_focusNode.hasFocus && widget.controller != null) {
//         widget.controller.selection = TextSelection(
//             baseOffset: 0, extentOffset: widget.controller.text.length);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 32,
//       padding: widget.padding ?? EdgeInsets.only(top: 1),
//       decoration: BoxDecoration(
//         // color: Colors.white,
//         border: Border(
//           bottom: BorderSide(
//             color: widget.isWarning
//                 ? MyColors.warning_light
//                 : MyColors.gray_555555,
//             width: widget.isWarning ? 2 : 0.6,
//           ),
//           right: BorderSide(
//             color: widget.isWarning
//                 ? MyColors.warning_light
//                 : MyColors.gray_555555,
//             width: widget.isWarning ? 2 : 0.4,
//           ),
//         ),
//       ),
//       child: CupertinoTextField(
//         key: widget.key,
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//         controller: widget.controller,
//         placeholder: widget.placeholder,
//         placeholderStyle: TextStyle(
//           color: MyColors.textSecondary,
//           fontSize: 12.0,
//         ),
//         decoration: BoxDecoration(
//           color: widget.bgColor,
//         ),
//         style: TextStyle(
//           color: MyColors.textPrimary,
//           fontSize: 16.0,
//         ),
//         keyboardType: widget.inputType ?? TextInputType.text,
//         clearButtonMode: OverlayVisibilityMode.editing,
//         enabled: widget.enabled,
//         focusNode: _focusNode,
//         // autofocus: true,
//       ),
//     );
//   }
// }
