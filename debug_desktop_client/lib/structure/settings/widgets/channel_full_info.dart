import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/tools/uikit.dart';

class ChannelFullInfoScreen extends StatefulWidget {
  const ChannelFullInfoScreen({
    this.log,
    this.index,
  });

  final Log log;
  final int index;

  @override
  ChannelFullInfoState createState() => ChannelFullInfoState();
}

class ChannelFullInfoState extends State<ChannelFullInfoScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: MyColors.gray_e5e5e5,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          width: 1.0,
          color: MyColors.gray_666666,
        ),
      ),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(), // NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          // tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: _PayloadDelegate(
              child: Container(
                decoration: const BoxDecoration(
                  color: MyColors.gray_d8d8d8,
                ),
                child: CupertinoTabBar(
                  currentIndex: _currentTabIndex,
                  activeColor: MyColors.warning,
                  onTap: (int index) {
                    setState(() {
                      _currentTabIndex = index;
                    });
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.add),
                      title: Text(
                        'action payload',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.add),
                      title: Text(
                        'state',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // content
          SliverToBoxAdapter(
            child: Text(
              _currentTabIndex == 0 ? widget.log.actionPayload : widget.log.state,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayloadDelegate extends SliverPersistentHeaderDelegate {
  _PayloadDelegate({
    this.minHeight = 48.0,
    this.maxHeight = 48.0,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => maxHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_PayloadDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
