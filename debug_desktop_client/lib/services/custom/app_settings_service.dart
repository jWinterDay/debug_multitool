import 'package:debug_desktop_client/mobx/app_settings_state.dart';
import 'package:debug_desktop_client/services/db_service.dart';
import 'package:flutter/foundation.dart';

class AppSettingsService {
  AppSettingsService({
    @required this.dbService,
  });

  final DbService dbService;

  Future<AppSettingsState> fetch() async {
    final List<Map<String, dynamic>> rawList = await dbService.database.rawQuery(
      '''
      select app_settings_id as appSettingsId,
             name as name,
             value as value
        from app_settings
      ''',
    );

    return AppSettingsState.fromList(rawList);
  }

  Future<void> update(int id, String value) async {
    await dbService.database.rawUpdate(
      '''
      update app_settings
        set value = ?
      where app_settings_id = ?
      ''',
      <dynamic>[
        value,
        id,
      ],
    );
  }
}
