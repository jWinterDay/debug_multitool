import 'package:debug_desktop_client/mobx/log_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/tools/uikit.dart';

class ChannelCardScreen extends StatefulWidget {
  const ChannelCardScreen({
    this.logState,
    this.index,
    this.selected,
  });

  final LogState logState;
  final int index;
  final bool selected;

  @override
  _ChannelCardState createState() => _ChannelCardState();
}

class _ChannelCardState extends State<ChannelCardScreen> {
  @override
  Widget build(BuildContext context) {
    Color cardColor;
    switch (widget.logState.log.action) {
      case 'connect':
        cardColor = MyColors.primary.withOpacity(0.1);
        break;
      case 'disconnect':
        cardColor = MyColors.blue.withOpacity(0.1);
        break;
      default:
        cardColor = MyColors.gray_e5e5e5;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: widget.selected ? MyColors.primary : cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          width: 1.0,
          color: MyColors.gray_666666,
        ),
      ),
      child: Row(
        children: <Widget>[
          if (widget.logState.log.enabled)
            Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                CupertinoIcons.heart,
                color: MyColors.red,
              ),
            ),
          Expanded(
            child: Text(
              widget.logState.viewedText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
