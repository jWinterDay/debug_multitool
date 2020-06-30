import 'dart:async';
import 'package:debug_desktop_client/app_db.dart';
import 'package:debug_desktop_client/mobx/app_settings_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app_config.dart';
import 'app_di.dart';
import 'app_translations.dart';
import 'services/logger_service.dart';
import 'structure/app.dart';
import 'tools/uikit.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    AppConfig.init(isUiTesting: false);
    await AppDI.init();
    await AppTranslations.init();
    await AppDb.init();
    // await AppLocalStorage.init();

    runApp(_Main());
  }, (Object error, StackTrace stack) {
    di.get<LoggerService>().e('$error, stack: $stack');
  });
}

class _Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<ChannelState>(create: (_) => ChannelState()),
        Provider<AppSettingsState>(create: (_) => AppSettingsState()),
      ],
      child: Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        child: CupertinoApp(
          navigatorKey: AppConfig.rootNavigatorKey,
          debugShowCheckedModeBanner: false,
          theme: kAppTheme,
          home: App(),
        ),
      ),
    );
  }
}
