import 'package:flutter/cupertino.dart';
import 'package:debug_desktop_client/app_translations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(appTranslations.text('home')),
        previousPageTitle: appTranslations.text('common_back'),
      ),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          // safearea
          SliverToBoxAdapter(
            child: SafeArea(
              child: Container(height: 16.0),
              top: false,
            ),
          ),
        ],
      ),
    );
  }
}
