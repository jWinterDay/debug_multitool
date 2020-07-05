import 'package:centrifugo_flutter_client/src/models/used_url.dart';
import 'package:centrifugo_flutter_client/src/utils/hive_boxes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UrlDialogWidget extends StatefulWidget {
  const UrlDialogWidget({
    Key key,
  }) : super(key: key);

  @override
  _UrlDialogState createState() => _UrlDialogState();
}

class _UrlDialogState extends State<UrlDialogWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _sliveTitle(String title) {
    return SliverToBoxAdapter(
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _sliveItem(UsedUrl usedUrl) {
    return SliverToBoxAdapter(
      child: Row(
        children: <Widget>[
          const Icon(Icons.ac_unit),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(usedUrl.name);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  usedUrl.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // delete
          GestureDetector(
            onTap: () {
              //delete
            },
            child: const Icon(
              Icons.delete_sweep,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ValueListenableBuilder<Box<UsedUrl>>(
        valueListenable: Hive.box<UsedUrl>(HiveBoxes.usedUrl).listenable(),
        builder: (_, Box<UsedUrl> box, __) {
          final Map<dynamic, UsedUrl> rawMap = box.toMap();
          final List<UsedUrl> list = rawMap.values.toList();

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
                      slivers: <Widget>[
                        // persistent
                        _sliveTitle('Persistent values'),

                        ...list.where((UsedUrl usedUrl) {
                          return usedUrl.isPermanent;
                        }).map((UsedUrl usedUrl) {
                          return _sliveItem(usedUrl);
                        }),

                        // custom
                        _sliveTitle('Custom values'),

                        ...list.where((UsedUrl usedUrl) {
                          return !usedUrl.isPermanent;
                        }).map((UsedUrl usedUrl) {
                          return _sliveItem(usedUrl);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
