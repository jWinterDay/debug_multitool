import 'package:debug_desktop_client/app_di.dart';
import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/services/db_service.dart';

class ChannelService {
  DbService _dbService = di.get<DbService>();

  Future<List<String>> fetch() async {
    // final result =
    _dbService.database.rawQuery('''
      select ws_url,
             name,
             description,
             is_white_list_used,
             is_black_list_used,
             filter_white_list,
             filter_black_list
        from channel
      ''').then((value) {
      value.forEach((element) {
        print('----------------$element');
      });
    });

    // print('result = $result');

    return [];
  }

  Future<void> add(Channel channel) async {
    // await _dbService.database.rawInsert(
    //   '''
    //     insert into channel(
    //       ws_url,
    //       name,
    //       description,
    //       is_white_list_used,
    //       is_black_list_used,
    //       filter_white_list,
    //       filter_black_list)
    //     values (?,?,?,?,?,?,?)
    //     ''',
    //   [
    //     channel.wsUrl,
    //     channel.name,
    //     channel.description ?? '',
    //     channel.isWhiteListUsed ? 1 : 0,
    //     channel.isBlackListUsed ? 1 : 0,
    //     channel.filterWhiteList ?? '',
    //     channel.filterBlackList ?? ''
    //   ],
    // );
  }

  Future<void> update(Channel channel) async {
    // await _dbService.database.rawUpdate(
    //   '''
    //     update channel
    //       set ws_url = ?,
    //           description = ?,
    //           is_white_list_used = ?,
    //           is_black_list_used = ?,
    //           filter_white_list = ?,
    //           filter_black_list = ?
    //     where name = ?
    //     ''',
    //   [
    //     channel.wsUrl,
    //     channel.description,
    //     channel.isWhiteListUsed ? 1 : 0,
    //     channel.isBlackListUsed ? 1 : 0,
    //     channel.filterWhiteList,
    //     channel.filterBlackList,
    //     channel.name, // name is PK
    //   ],
    // );
  }

  Future<void> delete(Channel channel) async {
    // await _dbService.database.rawDelete(
    //   '''
    //     delete from channel where name = ?
    //     ''',
    //   [channel.name],
    // );
  }
}
