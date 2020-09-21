import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/tools/logger_icons.dart';

import 'channel_dialog_bloc.dart';

class ChannelDialog extends StatefulWidget {
  const ChannelDialog({
    Key key,
    @required this.currentChannelModel,
  }) : super(key: key);

  final ChannelModel currentChannelModel;

  @override
  State createState() => _ChannelDialogState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ChannelModel>('currentChannelModel', currentChannelModel));
  }
}

class _ChannelDialogState extends State<ChannelDialog> {
  ChannelDialogBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = ChannelDialogBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Material(
          child: Container(
            width: 220,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray6.withOpacity(0.2),
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 20.0,
                )
              ],
              color: AppColors.background,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _item(
                  iconData: LoggerIcons.edit_1x,
                  iconColor: AppColors.eventDelimiter,
                  title: 'Edit name',
                  callback: () {
                    _bloc.pop(context);
                    _bloc.showChannelEditor(context, widget.currentChannelModel);
                  },
                ),
                _item(
                  iconData: LoggerIcons.trash_1x,
                  iconColor: AppColors.red,
                  title: 'Delete',
                  callback: () {
                    _bloc.removeChannel(widget.currentChannelModel);
                    _bloc.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item({
    @required IconData iconData,
    @required Color iconColor,
    @required String title,
    @required VoidCallback callback,
  }) {
    return InkWell(
      onTap: () => callback(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0).copyWith(left: 15.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.gray6.withOpacity(0.2),
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                iconData,
                size: 20.0,
                color: iconColor,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
