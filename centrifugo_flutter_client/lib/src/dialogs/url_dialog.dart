import 'package:centrifugo_flutter_client/src/dialogs/components/item_sliver_title.dart';
import 'package:centrifugo_flutter_client/src/models/used_url.dart';
import 'package:centrifugo_flutter_client/src/utils/hive_boxes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/item_sliver_content.dart';

class UrlDialogWidget extends StatefulWidget {
  const UrlDialogWidget({
    Key key,
  }) : super(key: key);

  @override
  _UrlDialogState createState() => _UrlDialogState();
}

class _UrlDialogState extends State<UrlDialogWidget> {
  List<Widget> _sliverItems(Map<dynamic, UsedUrl> rawMap) {
    return <Widget>[
      // persistent
      if (rawMap.values.any((UsedUrl commonDialogItem) => commonDialogItem.isPermanent))
        const ItemSliverTitle(title: 'Persistent values'),

      ...rawMap.entries.where((MapEntry<dynamic, UsedUrl> item) {
        return item.value.isPermanent;
      }).map<Widget>((MapEntry<dynamic, UsedUrl> item) {
        return ItemSliverContent(
          name: item.value.name,
          isPermanent: item.value.isPermanent,
        );
      }).toList(),

      // custom
      if (rawMap.values.any((UsedUrl commonDialogItem) => !commonDialogItem.isPermanent))
        const ItemSliverTitle(title: 'Custom values'),

      ...rawMap.entries.where((MapEntry<dynamic, UsedUrl> item) {
        return !item.value.isPermanent;
      }).map<Widget>((MapEntry<dynamic, UsedUrl> item) {
        return ItemSliverContent(
          name: item.value.name,
          isPermanent: item.value.isPermanent,
        );
      }).toList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ValueListenableBuilder<Box<UsedUrl>>(
      valueListenable: Hive.box<UsedUrl>(HiveBoxes.usedUrl).listenable(),
      builder: (_, Box<UsedUrl> box, __) {
        final Map<dynamic, UsedUrl> rawMap = box.toMap();

        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 0.9 * size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
            ),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('select url'),
              ),
              body: Container(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox.expand(
                  child: CustomScrollView(
                    slivers: _sliverItems(rawMap),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
