import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/cupertino.dart';

class MyInputText extends StatelessWidget {
  const MyInputText({
    @required this.textEditingController,
    this.placeholder,
    this.enabled = true,
    this.decoration,
    @required this.child,
  })  : assert(textEditingController != null),
        assert(enabled != null);

  final String placeholder;
  final TextEditingController textEditingController;
  final bool enabled;
  final BoxDecoration decoration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: MyColors.gray_b3b3b3,
      ),
      child: Row(
        children: <Widget>[
          // header
          Expanded(
            child: CupertinoTextField(
              placeholder: placeholder,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              controller: textEditingController,
              clearButtonMode: enabled ? OverlayVisibilityMode.always : OverlayVisibilityMode.never,
              decoration: decoration ?? BoxDecoration(color: enabled ? MyColors.white : MyColors.gray_d8d8d8),
              enabled: enabled,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // child
          if (child != null) child,
        ],
      ),
    );
  }
}
