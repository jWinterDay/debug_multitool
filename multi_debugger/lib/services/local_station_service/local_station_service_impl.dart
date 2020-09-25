import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:go_flutter_utils/go_flutter_utils.dart';
import 'package:multi_debugger/services/logger_service/logger_service.dart';

import 'local_station_service.dart';

class LocalStationServiceImpl extends LocalStationService {
  LocalStationServiceImpl({
    @required this.loggerService,
  }) : assert(loggerService != null);

  final LoggerService loggerService;

  final GoFlutterUtils _goFlutterUtils = GoFlutterUtils();

  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<String> fetchComputerName({Duration timeout}) async {
    // TODO(jWinterDay): remake
    Map<String, dynamic> info;
    String hostName = 'unknown';

    if (kIsWeb) {
      return 'web_platform';
    }

    try {
      info = await _goFlutterUtils.getInfo();
      hostName = info['hostName'].toString();
    } on PlatformException catch (error) {
      loggerService.e('fetchComputerName error: $error');
    }

    return hostName;
  }
}
