// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used_url_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsedUrlState on _UsedUrlState, Store {
  final _$channelListAtom = Atom(name: '_UsedUrlState.channelList');

  @override
  ObservableList<UsedUrl> get channelList {
    _$channelListAtom.reportRead();
    return super.channelList;
  }

  @override
  set channelList(ObservableList<UsedUrl> value) {
    _$channelListAtom.reportWrite(value, super.channelList, () {
      super.channelList = value;
    });
  }

  @override
  String toString() {
    return '''
channelList: ${channelList}
    ''';
  }
}
