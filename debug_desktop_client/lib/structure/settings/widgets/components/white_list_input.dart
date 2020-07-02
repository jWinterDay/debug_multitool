import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/cupertino.dart';

typedef UseWhiteListCallback = void Function(bool val);

class WhiteListInput extends StatelessWidget {
  const WhiteListInput({
    @required this.text,
    @required this.callback,
    @required this.isWhiteListUsed,
  })  : assert(text != null),
        assert(callback != null),
        assert(isWhiteListUsed != null);

  final String text;
  final UseWhiteListCallback callback;
  final bool isWhiteListUsed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: MyColors.gray_b3b3b3,
        border: Border.all(color: MyColors.blue),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          //
          Container(
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
          //
        ],
      ),
    );
  }
}
