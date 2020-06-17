import 'package:flutter/cupertino.dart';
import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/mobx/channel_list.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ChannelDialogScreen extends StatefulWidget {
  const ChannelDialogScreen();

  @override
  _ChannelDialogState createState() => _ChannelDialogState();
}

class _ChannelDialogState extends State<ChannelDialogScreen> {
  TextEditingController _textEditingController;
  BehaviorSubject<bool> _addEnabledSubject;
  Stream<bool> get _addEnabledStream => _addEnabledSubject.stream;
  String get _currentText => _textEditingController.text;

  @override
  void initState() {
    super.initState();

    _addEnabledSubject = BehaviorSubject<bool>();
    _textEditingController = TextEditingController(text: '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ChannelList store = Provider.of<ChannelList>(context, listen: false);

      _textEditingController.addListener(() {
        final bool notExists = store.getChannelByName(_currentText) == null;
        final bool notEmpty = _currentText != '';

        _addEnabledSubject.add(notExists && notEmpty);
      });
    });
  }

  @override
  void dispose() {
    _addEnabledSubject.close();

    super.dispose();
  }

  void _add(ChannelList store) {
    store.addChannel(_currentText);

    Navigator.of(context).pop(_currentText);
  }

  @override
  Widget build(BuildContext context) {
    final ChannelList store = Provider.of<ChannelList>(context);

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: const BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // name
            Container(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(
                autofocus: true,
                controller: _textEditingController,
              ),
            ),

            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CupertinoButton(
                  color: MyColors.gray_999999,
                  child: Text(appTranslations.text('common_cancel')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                StreamBuilder<bool>(
                  stream: _addEnabledStream,
                  initialData: false,
                  builder: (_, AsyncSnapshot<bool> snapshot) {
                    return CupertinoButton(
                      color: MyColors.red.withOpacity(0.3),
                      child: Text(appTranslations.text('common_add')),
                      onPressed: snapshot.data ? () => _add(store) : null,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
