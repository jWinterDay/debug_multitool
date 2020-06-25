import 'package:debug_desktop_client/mobx/used_url.dart';
import 'package:debug_desktop_client/mobx/used_url_state.dart';
import 'package:debug_desktop_client/services/db_service.dart';
import 'package:flutter/foundation.dart';

class UsedUrlService {
  UsedUrlService({
    @required this.dbService,
  });

  final DbService dbService;

  Future<List<UsedUrl>> fetch() async {
    final List<Map<String, dynamic>> rawList = await dbService.database.rawQuery(
      '''
      select used_url_id as usedUrlId,
             name as name,
             is_permanent as isPermanent
        from used_url
      ''',
    );

    return UsedUrlState.fromList(rawList);
  }

  Future<UsedUrl> fetchSingle(int usedUrlId) async {
    final List<Map<String, dynamic>> rawList = await dbService.database.rawQuery(
      '''
      select used_url_id as usedUrlId,
             name as name,
             is_permanent as isPermanent
        from used_url
       where used_url_id = ?
      ''',
      [usedUrlId],
    );

    if (rawList.isEmpty) {
      return null;
    }

    return UsedUrl.fromMap(rawList.first);
  }

  Future<bool> existsById(int usedUrlId) async {
    return await fetchSingle(usedUrlId) != null;
  }

  Future<UsedUrl> add(String name) async {
    final int usedUrlId = await dbService.database.rawInsert(
      '''
        insert into used_url(
          name,
          is_permanent
        )
        select ?, 0
         where not exists(select 1 from used_url where name = ?)
      ''',
      [name, name],
    );

    final UsedUrl usedUrl = await fetchSingle(usedUrlId);

    return usedUrl;
  }

  Future<void> update(UsedUrl usedUrl) async {
    await dbService.database.rawUpdate(
      '''
      update used_url
        set name = ?
      where used_url_id = ?
      ''',
      [
        usedUrl.name ?? '',
        usedUrl.usedUrlId,
      ],
    );
  }

  Future<int> delete(UsedUrl usedUrl) async {
    final int count = await dbService.database.rawDelete(
      '''
      delete from used_url
       where used_url_id = ?
         and is_permanent = 0
      ''',
      [usedUrl.usedUrlId],
    );

    return count;
  }

  Future<int> deleteAll() async {
    final int count = await dbService.database.rawDelete(
      '''
      delete from used_url
       where is_permanent = 0
      ''',
    );

    return count;
  }
}
