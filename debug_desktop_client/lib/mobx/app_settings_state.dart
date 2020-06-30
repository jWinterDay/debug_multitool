import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/services/custom/app_settings_service.dart';
import 'package:mobx/mobx.dart';

part 'app_settings_state.g.dart';

const int kScrollToEndDbId = 1;

class AppSettingsState extends _AppSettingsState with _$AppSettingsState {
  static AppSettingsState fromList(List<Map<String, dynamic>> list) {
    AppSettingsState result = AppSettingsState();

    list.forEach((Map<String, dynamic> row) {
      final int id = int.parse(row['appSettingsId'].toString());
      final String value = row['value'];

      switch (id) {
        case 1:
          result..scrollToEnd = value == '1';
          break;

        default:
      }
    });

    return result;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'scrollToEnd': scrollToEnd,
    };
  }
}

abstract class _AppSettingsState with Store {
  AppSettingsService _appSettingsService = di.get<AppSettingsService>();

  @observable
  bool scrollToEnd = false;

  @action
  void setScrollToEnd(bool val) {
    scrollToEnd = val;

    _appSettingsService.update(kScrollToEndDbId, val ? '1' : '0');
  }

  @action
  void setSettings(AppSettingsState appSettingsState) {
    scrollToEnd = appSettingsState?.scrollToEnd ?? true;
  }
}
