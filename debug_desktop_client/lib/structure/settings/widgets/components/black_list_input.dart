import 'package:debug_desktop_client/app_config.dart';
import 'package:debug_desktop_client/structure/back_animation/utils/cool_route.dart';
import 'package:debug_desktop_client/structure/components/input_text.dart';
import 'package:debug_desktop_client/structure/settings/widgets/channel_filter_dialog.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/cupertino.dart';

typedef UseBlackListCallback = void Function(bool val);

class BlackListInput extends StatelessWidget {
  const BlackListInput({
    @required this.callback,
    @required this.text,
    @required this.isBlackListUsed,
  })  : assert(callback != null),
        assert(text != null),
        assert(isBlackListUsed != null);

  final String text;
  final UseBlackListCallback callback;
  final bool isBlackListUsed;

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
          GestureDetector(
            onTap: () async {
              await AppConfig.rootNavigator.push<dynamic>(
                CoolRoute<dynamic>(
                  barrierColor: MyColors.black.withOpacity(0.5),
                  builder: (_) => const ChannelFilterDialogScreen(
                    isWhite: false,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(right: 8.0),
              color: MyColors.transparent,
              child: const Icon(CupertinoIcons.settings),
            ),
          ),

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
          //
        ],
      ),
    );
  }
}
