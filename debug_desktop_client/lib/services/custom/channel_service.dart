import 'package:debug_desktop_client/mobx/channel.dart';
import 'package:debug_desktop_client/mobx/channel_filter.dart';
import 'package:debug_desktop_client/mobx/channel_state.dart';
import 'package:debug_desktop_client/services/db_service.dart';
import 'package:flutter/foundation.dart';

class ChannelService {
  ChannelService({
    @required this.dbService,
  });

  final DbService dbService;

  Future<List<Channel>> fetch() async {
    // channels
    final List<Map<String, dynamic>> rawChannelList = await dbService.database.rawQuery(
      '''
      select channel_id as channelId,
             ws_url as wsUrl,
             name as name,
             description as description,
             is_white_list_used as isWhiteListUsed,
             is_black_list_used as isBlackListUsed,
             filter_white_list as filterWhiteList,
             filter_black_list as filterBlackList
        from channel t
      ''',
    );

    final List<Channel> channelList = ChannelState.fromList(rawChannelList);

    // filters
    final List<Map<String, dynamic>> rawFilterList = await dbService.database.rawQuery(
      '''
      select channel_filter_id as channelFilterId,
             channel_id as channelId,
             name as name,
             is_white as isWhite
        from channel_filter t
      ''',
    );

    final List<ChannelFilter> filterList = rawFilterList.map((Map<String, dynamic> filter) {
      return ChannelFilter.fromMap(filter);
    }).toList();

    channelList.forEach((Channel channel) {
      // white
      final List<String> whiteList = filterList
          .where((ChannelFilter filter) => filter.isWhite && filter.channelId == channel.channelId)
          .map((ChannelFilter filter) => filter.name)
          .toList();

      // black
      final List<String> blackList = filterList
          .where((ChannelFilter filter) => !filter.isWhite && filter.channelId == channel.channelId)
          .map((ChannelFilter filter) => filter.name)
          .toList();

      channel
        ..addWhiteList(whiteList)
        ..addBlackList(blackList);
    });

    return channelList;
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
  Future<int> addFilter(String channelName, String filter, {@required bool isWhite}) async {
    final int count = await dbService.database.rawUpdate(
      '''
      insert into channel_filter (
        channel_id,
        name,
        is_white
      )
      select channel_id,
             ?,
             ?
        from channel
       where name = ?
      ''',
      <dynamic>[
        filter,
        if (isWhite) 1 else 0,
        channelName,
      ],
    );

    return count;
  }

  Future<int> removeFilter(String channelName, String filter, {@required bool isWhite}) async {
    final int count = await dbService.database.rawDelete(
      '''
      delete from channel_filter
       where name = ?
         and is_white = ?
         and channel_id = (select channel_id
                             from channel
                            where name = ?)
      ''',
      <dynamic>[
        filter,
        if (isWhite) 1 else 0,
        channelName,
      ],
    );

    return count;
  }
}
