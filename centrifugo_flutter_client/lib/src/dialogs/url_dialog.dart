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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Hive.box('settings').listenable(),

    // return ValueListenableBuilder<List<String>>(
    //   // valueListenable: Hive.box('settings').listenable(),
    //   builder: (_, List<String> value, Widget child) {
    //     return Text('fds');
    //   },
    //   // valueListenable: Hive.box('settings').listenable(),
    //   // builder: (context, box, widget) {
    //   //   return Switch(
    //   //       value: box.get('darkMode'),
    //   //       onChanged: (val) {
    //   //         box.put('darkMode', val);
    //   //       });
    //   // },
    // );

    return ValueListenableBuilder<Box<UsedUrl>>(
        valueListenable: Hive.box<UsedUrl>(HiveBoxes.usedUrl).listenable(),
        builder: (_, Box<UsedUrl> box, __) {
          print(box.length);
          // final t = snapshot.data;
          // print('t = $t');

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
                      slivers: [
                        SliverToBoxAdapter(
                          child: Text('fsdfds'),
                        )
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
