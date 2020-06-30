import 'package:debug_desktop_client/structure/components/input_text.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/cupertino.dart';

typedef UseWhiteListCallback = void Function(bool val);

class WhiteListInput extends StatelessWidget {
  const WhiteListInput({
    @required this.controller,
    @required this.callback,
    @required this.isWhiteListUsed,
  })  : assert(controller != null),
        assert(callback != null),
        assert(isWhiteListUsed != null);

  final TextEditingController controller;
  final UseWhiteListCallback callback;
  final bool isWhiteListUsed;

  @override
  Widget build(BuildContext context) {
    return MyInputText(
      textEditingController: controller,
      placeholder: 'white list',
      decoration: BoxDecoration(color: isWhiteListUsed ? MyColors.white : MyColors.gray_d8d8d8),
      child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 16.0),
        child: Row(
          children: <Widget>[
            const Text(
              'White list',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CupertinoSwitch(
              value: isWhiteListUsed,
              onChanged: callback,
            ),
          ],
        ),
      ),
    );
  }
}
