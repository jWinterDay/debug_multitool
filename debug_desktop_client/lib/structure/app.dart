import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/mobx/app_settings_state.dart';
import 'package:debug_desktop_client/services/custom/app_settings_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:debug_desktop_client/app_translations.dart';
import 'package:debug_desktop_client/structure/back_animation/widgets/screen_back_animation.dart';
import 'package:debug_desktop_client/structure/home/home.dart';
import 'package:provider/provider.dart';

import 'settings/widgets/settings_screen.dart';

/// class for mapping bottom navigation bar item and their screen
@immutable
class _TabProp {
  const _TabProp({
    @required this.navigationBarItem,
    @required this.screen,
  });

  final BottomNavigationBarItem navigationBarItem;
  final Widget screen;
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  CupertinoTabController _tabController;
  List<_TabProp> _tabPropList;

  AppSettingsService _appSettingsService = di.get<AppSettingsService>();

  @override
  void initState() {
    super.initState();

    // app settings
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final AppSettingsState appSettingsState = Provider.of<AppSettingsState>(context, listen: false);

      _appSettingsService.fetch().then((settings) {
        print('app init state settings = $settings');

        appSettingsState.setSettings(settings);
      });
    });

    // tabs
    _tabController = CupertinoTabController(initialIndex: 0);

    _tabPropList = <_TabProp>[
      // settings
      _TabProp(
        navigationBarItem: BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.tags),
          title: Text(appTranslations.text('settings')),
        ),
        screen: const SettingsScreen(),
      ),

      // home
      _TabProp(
        navigationBarItem: BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: Text(appTranslations.text('home')),
        ),
        screen: const HomeScreen(),
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackAnimation(
      child: CupertinoTabScaffold(
        resizeToAvoidBottomInset: true,
        controller: _tabController,
        tabBar: CupertinoTabBar(
          items: _tabPropList.map((_TabProp prop) => prop.navigationBarItem).toList(),
        ),
        tabBuilder: (_, int index) => _tabPropList[index].screen,
      ),
    );
  }
}
