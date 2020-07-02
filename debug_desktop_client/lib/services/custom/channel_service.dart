import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/services/db_service.dart';
import 'package:flutter/foundation.dart';

class ChannelService {
  ChannelService({
    @required this.dbService,
  });

  final DbService dbService;

  Future<List<Channel>> fetch() async {
    final List<Map<String, dynamic>> rawList = await dbService.database.rawQuery(
      '''
      select ws_url as wsUrl,
             name as name,
             description as description,
             is_white_list_used as isWhiteListUsed,
             is_black_list_used as isBlackListUsed,
             filter_white_list as filterWhiteList,
             filter_black_list as filterBlackList
        from channel t
      ''',
    );

    // (select json_group_array(
    //                    json_object('channel_filter_id', channel_filter_id,
    //                                'channel_id', channel_id,
    //                                'name', name,
    //                                'is_white', is_white)
    //                  ) as json_result
    //             from (select * from channel_filter where channel_id = t.channel_id)
    //          ) as filters_json,

    rawList.forEach((Map<String, dynamic> element) {
      Channel channel = Channel.fromMap(element);
      print(' raw >>>>> channel = ${channel.name}');
      print('----------------$element');
    });

    // final t = ChannelState.fromList(rawList);

    return ChannelState.fromList(rawList);
  }

  Future<Channel> fetchSingle(String name) async {
    final List<Map<String, dynamic>> rawList = await dbService.database.rawQuery(
      '''
      select ws_url as wsUrl,
             name as name,
             description as description,
             is_white_list_used as isWhiteListUsed,
             is_black_list_used as isBlackListUsed,
             filter_white_list as filterWhiteList,
             filter_black_list as filterBlackList
        from channel
       where name = ?
      ''',
      <dynamic>[name],
    );

    if (rawList.isEmpty) {
      return null;
    }

    return Channel.fromMap(rawList.first);
  }

  Future<bool> existsByName(String name) async {
    return await fetchSingle(name) != null;
  }

  Future<bool> add(Channel channel) async {
    final bool exists = await existsByName(channel.name);
    if (exists) {
      return false;
    }

    await dbService.database.rawInsert(
      '''
        insert into channel(
          ws_url,
          name,
          description,
          is_white_list_used,
          is_black_list_used,
          filter_white_list,
          filter_black_list)
        values (?,?,?,?,?,?,?)
      ''',
      <dynamic>[
        channel.wsUrl ?? '',
        channel.name ?? 'name_1',
        channel.description ?? '',
        if (channel.isWhiteListUsed) 1 else 0,
        if (channel.isBlackListUsed) 1 else 0,
        channel.filterWhiteList ?? '',
        channel.filterBlackList ?? ''
      ],
    );

    return true;
  }

  Future<int> update(Channel channel) async {
    final int count = await dbService.database.rawUpdate(
      '''
      update channel
        set ws_url = ?,
            description = ?,
            is_white_list_used = ?,
            is_black_list_used = ?,
            filter_white_list = ?,
            filter_black_list = ?
      where name = ?
      ''',
      <dynamic>[
        channel.wsUrl ?? '',
        channel.description,
        if (channel.isWhiteListUsed) 1 else 0,
        if (channel.isBlackListUsed) 1 else 0,
        channel.filterWhiteList ?? '',
        channel.filterBlackList ?? '',
        channel.name ?? 'name_1', // name is PK
      ],
    );

    return count;
  }

  Future<int> delete(Channel channel) async {
    final int count = await dbService.database.rawDelete(
      '''
      delete from channel where name = ?
      ''',
      <dynamic>[channel.name ?? ''],
    );

    return count;
  }

  Future<int> deleteAll() async {
    final int count = await dbService.database.rawDelete(
      '''
      delete from channel
      ''',
    );

    return count;
  }

  // filters
  Future<List<Channel>> fetchFilters(Channel channel) async {
    final List<Map<String, dynamic>> rawList = await dbService.database.rawQuery(
      '''
      select channel_filter_id as channelFilterId,
             channel_id as channelId,
             name as name,
             is_white as isWhite
        from channel_filter
      ''',
    );

    // rawList.forEach((Map<String, dynamic> element) {
    //   Channel channel = Channel.fromMap(element);
    //   print(' raw >>>>> channel = ${channel.name}');
    //   print('----------------$element');
    // });

    // final t = ChannelState.fromList(rawList);

    return null;
    //ChannelState.fromList(rawList);
  }
}
