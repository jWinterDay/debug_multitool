// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChannelModel> _$channelModelSerializer = new _$ChannelModelSerializer();

class _$ChannelModelSerializer implements StructuredSerializer<ChannelModel> {
  @override
  final Iterable<Type> types = const [ChannelModel, _$ChannelModel];
  @override
  final String wireName = 'ChannelModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ChannelModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'channelId',
      serializers.serialize(object.channelId, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'shortName',
      serializers.serialize(object.shortName, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description, specifiedType: const FullType(String)),
      'isWhiteListUsed',
      serializers.serialize(object.isWhiteListUsed, specifiedType: const FullType(bool)),
      'isBlackListUsed',
      serializers.serialize(object.isBlackListUsed, specifiedType: const FullType(bool)),
      'showFavoriteOnly',
      serializers.serialize(object.showFavoriteOnly, specifiedType: const FullType(bool)),
      'isCurrent',
      serializers.serialize(object.isCurrent, specifiedType: const FullType(bool)),
      'useAutoScroll',
      serializers.serialize(object.useAutoScroll, specifiedType: const FullType(bool)),
      'serverConnectStatus',
      serializers.serialize(object.serverConnectStatus, specifiedType: const FullType(ServerConnectStatus)),
      'datetime',
      serializers.serialize(object.datetime, specifiedType: const FullType(DateTime)),
      'whiteList',
      serializers.serialize(object.whiteList, specifiedType: const FullType(BuiltList, const [const FullType(String)])),
      'blackList',
      serializers.serialize(object.blackList, specifiedType: const FullType(BuiltList, const [const FullType(String)])),
    ];
    if (object.wsUrl != null) {
      result..add('wsUrl')..add(serializers.serialize(object.wsUrl, specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ChannelModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChannelModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'channelId':
          result.channelId = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
        case 'shortName':
          result.shortName = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
        case 'wsUrl':
          result.wsUrl = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
        case 'isWhiteListUsed':
          result.isWhiteListUsed = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'isBlackListUsed':
          result.isBlackListUsed = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'showFavoriteOnly':
          result.showFavoriteOnly = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'isCurrent':
          result.isCurrent = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'useAutoScroll':
          result.useAutoScroll = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'serverConnectStatus':
          result.serverConnectStatus =
              serializers.deserialize(value, specifiedType: const FullType(ServerConnectStatus)) as ServerConnectStatus;
          break;
        case 'datetime':
          result.datetime = serializers.deserialize(value, specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'whiteList':
          result.whiteList.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [const FullType(String)])) as BuiltList<Object>);
          break;
        case 'blackList':
          result.blackList.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [const FullType(String)])) as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$ChannelModel extends ChannelModel {
  @override
  final String channelId;
  @override
  final String name;
  @override
  final String shortName;
  @override
  final String wsUrl;
  @override
  final String description;
  @override
  final bool isWhiteListUsed;
  @override
  final bool isBlackListUsed;
  @override
  final bool showFavoriteOnly;
  @override
  final bool isCurrent;
  @override
  final bool useAutoScroll;
  @override
  final ServerConnectStatus serverConnectStatus;
  @override
  final DateTime datetime;
  @override
  final BuiltList<String> whiteList;
  @override
  final BuiltList<String> blackList;

  factory _$ChannelModel([void Function(ChannelModelBuilder) updates]) =>
      (new ChannelModelBuilder()..update(updates)).build();

  _$ChannelModel._(
      {this.channelId,
      this.name,
      this.shortName,
      this.wsUrl,
      this.description,
      this.isWhiteListUsed,
      this.isBlackListUsed,
      this.showFavoriteOnly,
      this.isCurrent,
      this.useAutoScroll,
      this.serverConnectStatus,
      this.datetime,
      this.whiteList,
      this.blackList})
      : super._() {
    if (channelId == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'channelId');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'name');
    }
    if (shortName == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'shortName');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'description');
    }
    if (isWhiteListUsed == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'isWhiteListUsed');
    }
    if (isBlackListUsed == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'isBlackListUsed');
    }
    if (showFavoriteOnly == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'showFavoriteOnly');
    }
    if (isCurrent == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'isCurrent');
    }
    if (useAutoScroll == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'useAutoScroll');
    }
    if (serverConnectStatus == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'serverConnectStatus');
    }
    if (datetime == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'datetime');
    }
    if (whiteList == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'whiteList');
    }
    if (blackList == null) {
      throw new BuiltValueNullFieldError('ChannelModel', 'blackList');
    }
  }

  @override
  ChannelModel rebuild(void Function(ChannelModelBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  ChannelModelBuilder toBuilder() => new ChannelModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChannelModel &&
        channelId == other.channelId &&
        name == other.name &&
        shortName == other.shortName &&
        wsUrl == other.wsUrl &&
        description == other.description &&
        isWhiteListUsed == other.isWhiteListUsed &&
        isBlackListUsed == other.isBlackListUsed &&
        showFavoriteOnly == other.showFavoriteOnly &&
        isCurrent == other.isCurrent &&
        useAutoScroll == other.useAutoScroll &&
        serverConnectStatus == other.serverConnectStatus &&
        datetime == other.datetime &&
        whiteList == other.whiteList &&
        blackList == other.blackList;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc($jc($jc(0, channelId.hashCode), name.hashCode), shortName.hashCode),
                                                wsUrl.hashCode),
                                            description.hashCode),
                                        isWhiteListUsed.hashCode),
                                    isBlackListUsed.hashCode),
                                showFavoriteOnly.hashCode),
                            isCurrent.hashCode),
                        useAutoScroll.hashCode),
                    serverConnectStatus.hashCode),
                datetime.hashCode),
            whiteList.hashCode),
        blackList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChannelModel')
          ..add('channelId', channelId)
          ..add('name', name)
          ..add('shortName', shortName)
          ..add('wsUrl', wsUrl)
          ..add('description', description)
          ..add('isWhiteListUsed', isWhiteListUsed)
          ..add('isBlackListUsed', isBlackListUsed)
          ..add('showFavoriteOnly', showFavoriteOnly)
          ..add('isCurrent', isCurrent)
          ..add('useAutoScroll', useAutoScroll)
          ..add('serverConnectStatus', serverConnectStatus)
          ..add('datetime', datetime)
          ..add('whiteList', whiteList)
          ..add('blackList', blackList))
        .toString();
  }
}

class ChannelModelBuilder implements Builder<ChannelModel, ChannelModelBuilder> {
  _$ChannelModel _$v;

  String _channelId;
  String get channelId => _$this._channelId;
  set channelId(String channelId) => _$this._channelId = channelId;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _shortName;
  String get shortName => _$this._shortName;
  set shortName(String shortName) => _$this._shortName = shortName;

  String _wsUrl;
  String get wsUrl => _$this._wsUrl;
  set wsUrl(String wsUrl) => _$this._wsUrl = wsUrl;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  bool _isWhiteListUsed;
  bool get isWhiteListUsed => _$this._isWhiteListUsed;
  set isWhiteListUsed(bool isWhiteListUsed) => _$this._isWhiteListUsed = isWhiteListUsed;

  bool _isBlackListUsed;
  bool get isBlackListUsed => _$this._isBlackListUsed;
  set isBlackListUsed(bool isBlackListUsed) => _$this._isBlackListUsed = isBlackListUsed;

  bool _showFavoriteOnly;
  bool get showFavoriteOnly => _$this._showFavoriteOnly;
  set showFavoriteOnly(bool showFavoriteOnly) => _$this._showFavoriteOnly = showFavoriteOnly;

  bool _isCurrent;
  bool get isCurrent => _$this._isCurrent;
  set isCurrent(bool isCurrent) => _$this._isCurrent = isCurrent;

  bool _useAutoScroll;
  bool get useAutoScroll => _$this._useAutoScroll;
  set useAutoScroll(bool useAutoScroll) => _$this._useAutoScroll = useAutoScroll;

  ServerConnectStatus _serverConnectStatus;
  ServerConnectStatus get serverConnectStatus => _$this._serverConnectStatus;
  set serverConnectStatus(ServerConnectStatus serverConnectStatus) => _$this._serverConnectStatus = serverConnectStatus;

  DateTime _datetime;
  DateTime get datetime => _$this._datetime;
  set datetime(DateTime datetime) => _$this._datetime = datetime;

  ListBuilder<String> _whiteList;
  ListBuilder<String> get whiteList => _$this._whiteList ??= new ListBuilder<String>();
  set whiteList(ListBuilder<String> whiteList) => _$this._whiteList = whiteList;

  ListBuilder<String> _blackList;
  ListBuilder<String> get blackList => _$this._blackList ??= new ListBuilder<String>();
  set blackList(ListBuilder<String> blackList) => _$this._blackList = blackList;

  ChannelModelBuilder() {
    ChannelModel._initializeBuilder(this);
  }

  ChannelModelBuilder get _$this {
    if (_$v != null) {
      _channelId = _$v.channelId;
      _name = _$v.name;
      _shortName = _$v.shortName;
      _wsUrl = _$v.wsUrl;
      _description = _$v.description;
      _isWhiteListUsed = _$v.isWhiteListUsed;
      _isBlackListUsed = _$v.isBlackListUsed;
      _showFavoriteOnly = _$v.showFavoriteOnly;
      _isCurrent = _$v.isCurrent;
      _useAutoScroll = _$v.useAutoScroll;
      _serverConnectStatus = _$v.serverConnectStatus;
      _datetime = _$v.datetime;
      _whiteList = _$v.whiteList?.toBuilder();
      _blackList = _$v.blackList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChannelModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ChannelModel;
  }

  @override
  void update(void Function(ChannelModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChannelModel build() {
    _$ChannelModel _$result;
    try {
      _$result = _$v ??
          new _$ChannelModel._(
              channelId: channelId,
              name: name,
              shortName: shortName,
              wsUrl: wsUrl,
              description: description,
              isWhiteListUsed: isWhiteListUsed,
              isBlackListUsed: isBlackListUsed,
              showFavoriteOnly: showFavoriteOnly,
              isCurrent: isCurrent,
              useAutoScroll: useAutoScroll,
              serverConnectStatus: serverConnectStatus,
              datetime: datetime,
              whiteList: whiteList.build(),
              blackList: blackList.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'whiteList';
        whiteList.build();
        _$failedField = 'blackList';
        blackList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError('ChannelModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
