import 'package:debug_desktop_client/structure/components/input_text.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/cupertino.dart';

typedef void UseBlackListCallback(bool val);

class BlackListInput extends StatelessWidget {
  const BlackListInput({
    @required this.callback,
    @required this.controller,
    @required this.isBlackListUsed,
  })  : assert(callback != null),
        assert(controller != null),
        assert(isBlackListUsed != null);

  final TextEditingController controller;
  final UseBlackListCallback callback;
  final bool isBlackListUsed;

  @override
  Widget build(BuildContext context) {
    return MyInputText(
      textEditingController: controller,
      placeholder: 'black list',
      decoration: BoxDecoration(color: isBlackListUsed ? MyColors.white : MyColors.gray_d8d8d8),
      child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 16.0),
        child: Row(
          children: <Widget>[
            const Text(
              'Black list',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CupertinoSwitch(
              value: isBlackListUsed,
              onChanged: callback,
            ),
          ],
        ),
      ),
    );
  }
}
