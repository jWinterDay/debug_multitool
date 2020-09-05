// import 'package:device_simulator/device_simulator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_debugger/app/theme.dart';
import 'package:multi_debugger/app_globals.dart';
import 'package:multi_debugger/di/app_di.dart';

class App extends StatefulWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final AppGlobals _appGlobals = di.get<AppGlobals>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // actions.appLifecycle(convertToAppLifecycle(state));
  }

  @override
  Widget build(BuildContext context) {
    return ReduxProvider(
      store: _appGlobals.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text('fsd'),
          // ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'fdsfsdYouаываы have pushed the button this many times1231:',
                ),
              ],
            ),
          ),
        ),
        theme: appTheme,
        navigatorKey: _appGlobals.rootNavigatorKey,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
        ],
        builder: (_, Widget child) {
          return child;
        },
      ),
    );
  }
}

// AppLifecycle convertToAppLifecycle(AppLifecycleState state) {
//   switch (state) {
//     case AppLifecycleState.resumed:
//       return AppLifecycle.resumed;
//     case AppLifecycleState.inactive:
//       return AppLifecycle.inactive;
//     case AppLifecycleState.paused:
//       return AppLifecycle.paused;
//     case AppLifecycleState.detached:
//       return AppLifecycle.suspending;
//     default:
//       return AppLifecycle.none;
//   }
// }

// class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
//   const FallbackCupertinoLocalisationsDelegate();

//   @override
//   bool isSupported(Locale locale) => [
//         'ru',
//         'en',
//       ].contains(locale.languageCode);

//   @override
//   Future<CupertinoLocalizations> load(Locale locale) =>
//       SynchronousFuture<_DefaultCupertinoLocalizations>(_DefaultCupertinoLocalizations(locale));

//   @override
//   bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
// }

// class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
//   _DefaultCupertinoLocalizations(this.locale);

//   final Locale locale;

//   final monthEs = [
//     '',
//     'Enero',
//     'Febrero',
//     'Marzo',
//     'Abril',
//     'Mayo',
//     'Junio',
//     'Julio',
//     'Agosto',
//     'Septiembre',
//     'Octubre',
//     'Noviembre',
//     'Diciembre',
//   ];

//   @override
//   String datePickerMonth(int monthIndex) {
//     if (locale.languageCode == 'ru') {
//       return monthEs[monthIndex];
//     }

//     return super.datePickerMonth(monthIndex);
//   }

//   @override
//   String get alertDialogLabel => locale.languageCode == 'ru' ? 'Внимание' : 'Alert';
// }
