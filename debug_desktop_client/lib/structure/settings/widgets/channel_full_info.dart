import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/tools/uikit.dart';

enum _TabInfoType {
  actionPayload,
  state,
  diff,
}

class _TabInfo {
  _TabInfo({
    @required this.title,
    @required this.iconData,
    @required this.tabInfoType,
    @required this.viewedData,
  });

  final String title;
  final IconData iconData;
  final _TabInfoType tabInfoType;
  final String viewedData;
}

class ChannelFullInfoScreen extends StatefulWidget {
  const ChannelFullInfoScreen({
    this.log,
    // this.index,
  });

  final Log log;
  // final int index;

  @override
  _ChannelFullInfoState createState() => _ChannelFullInfoState();
}

class _ChannelFullInfoState extends State<ChannelFullInfoScreen> {
  _TabInfoType _currentTabInfoType = _TabInfoType.actionPayload;
  List<_TabInfo> _tabInfoList = [];

  @override
  void initState() {
    super.initState();

    _setTabList();
  }

  @override
  void didUpdateWidget(ChannelFullInfoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    _setTabList();
  }

  void _setTabList() {
    _tabInfoList = [
      _TabInfo(
        title: 'action payload',
        iconData: CupertinoIcons.bell,
        tabInfoType: _TabInfoType.actionPayload,
        viewedData: widget.log.actionPayload,
      ),
      _TabInfo(
        title: 'state',
        iconData: CupertinoIcons.car,
        tabInfoType: _TabInfoType.state,
        viewedData: widget.log.state,
      ),
      _TabInfo(
        title: 'diff',
        iconData: CupertinoIcons.eye,
        tabInfoType: _TabInfoType.diff,
        viewedData: 'todo',
      )
    ];
  }

  String get _tabTitle {
    final _TabInfo tabInfo = _tabInfoList.singleWhere((_TabInfo tabInfo) {
      return tabInfo.tabInfoType == _currentTabInfoType;
    }, orElse: () => null);

    return tabInfo.viewedData ?? 'unknown tab';
  }

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
        physics: const ClampingScrollPhysics(),
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
                  currentIndex: _currentTabInfoType.index,
                  activeColor: MyColors.warning,
                  onTap: (int index) {
                    setState(() {
                      _currentTabInfoType = _TabInfoType.values.firstWhere((element) => element.index == index);
                    });
                  },
                  items: _tabInfoList.map((_TabInfo tabInfo) {
                    return BottomNavigationBarItem(
                      icon: Icon(tabInfo.iconData),
                      title: Text(
                        tabInfo.title,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // content
          SliverToBoxAdapter(
            child: Text(
              _tabTitle,
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
