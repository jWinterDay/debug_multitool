import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:debug_desktop_client/app_local_storage.dart';
import 'package:debug_desktop_client/mobx/channel_list.dart';
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
    await AppLocalStorage.init();

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
        Provider<ChannelList>(create: (_) => ChannelList()),
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
