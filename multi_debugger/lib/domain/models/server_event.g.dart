// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ServerEvent> _$serverEventSerializer = new _$ServerEventSerializer();

class _$ServerEventSerializer implements StructuredSerializer<ServerEvent> {
  @override
  final Iterable<Type> types = const [ServerEvent, _$ServerEvent];
  @override
  final String wireName = 'ServerEvent';

  @override
  Iterable<Object> serialize(Serializers serializers, ServerEvent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'serverEventId',
      serializers.serialize(object.serverEventId, specifiedType: const FullType(String)),
      'action',
      serializers.serialize(object.action, specifiedType: const FullType(String)),
      'serverEventType',
      serializers.serialize(object.serverEventType, specifiedType: const FullType(ServerEventType)),
      'datetime',
      serializers.serialize(object.datetime, specifiedType: const FullType(DateTime)),
      'favorite',
      serializers.serialize(object.favorite, specifiedType: const FullType(bool)),
    ];
    if (object.payload != null) {
      result..add('payload')..add(serializers.serialize(object.payload, specifiedType: const FullType(JsonObject)));
    }
    if (object.state != null) {
      result..add('state')..add(serializers.serialize(object.state, specifiedType: const FullType(JsonObject)));
    }
    return result;
  }

  @override
  ServerEvent deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ServerEventBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'serverEventId':
          result.serverEventId = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
        case 'action':
          result.action = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
        case 'payload':
          result.payload = serializers.deserialize(value, specifiedType: const FullType(JsonObject)) as JsonObject;
          break;
        case 'state':
          result.state = serializers.deserialize(value, specifiedType: const FullType(JsonObject)) as JsonObject;
          break;
        case 'serverEventType':
          result.serverEventType =
              serializers.deserialize(value, specifiedType: const FullType(ServerEventType)) as ServerEventType;
          break;
        case 'datetime':
          result.datetime = serializers.deserialize(value, specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'favorite':
          result.favorite = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ServerEvent extends ServerEvent {
  @override
  final String serverEventId;
  @override
  final String action;
  @override
  final JsonObject payload;
  @override
  final JsonObject state;
  @override
  final ServerEventType serverEventType;
  @override
  final DateTime datetime;
  @override
  final bool favorite;

  factory _$ServerEvent([void Function(ServerEventBuilder) updates]) =>
      (new ServerEventBuilder()..update(updates)).build();

  _$ServerEvent._(
      {this.serverEventId, this.action, this.payload, this.state, this.serverEventType, this.datetime, this.favorite})
      : super._() {
    if (serverEventId == null) {
      throw new BuiltValueNullFieldError('ServerEvent', 'serverEventId');
    }
    if (action == null) {
      throw new BuiltValueNullFieldError('ServerEvent', 'action');
    }
    if (serverEventType == null) {
      throw new BuiltValueNullFieldError('ServerEvent', 'serverEventType');
    }
    if (datetime == null) {
      throw new BuiltValueNullFieldError('ServerEvent', 'datetime');
    }
    if (favorite == null) {
      throw new BuiltValueNullFieldError('ServerEvent', 'favorite');
    }
  }

  @override
  ServerEvent rebuild(void Function(ServerEventBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  ServerEventBuilder toBuilder() => new ServerEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServerEvent &&
        serverEventId == other.serverEventId &&
        action == other.action &&
        payload == other.payload &&
        state == other.state &&
        serverEventType == other.serverEventType &&
        datetime == other.datetime &&
        favorite == other.favorite;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc($jc(0, serverEventId.hashCode), action.hashCode), payload.hashCode), state.hashCode),
                serverEventType.hashCode),
            datetime.hashCode),
        favorite.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ServerEvent')
          ..add('serverEventId', serverEventId)
          ..add('action', action)
          ..add('payload', payload)
          ..add('state', state)
          ..add('serverEventType', serverEventType)
          ..add('datetime', datetime)
          ..add('favorite', favorite))
        .toString();
  }
}

class ServerEventBuilder implements Builder<ServerEvent, ServerEventBuilder> {
  _$ServerEvent _$v;

  String _serverEventId;
  String get serverEventId => _$this._serverEventId;
  set serverEventId(String serverEventId) => _$this._serverEventId = serverEventId;

  String _action;
  String get action => _$this._action;
  set action(String action) => _$this._action = action;

  JsonObject _payload;
  JsonObject get payload => _$this._payload;
  set payload(JsonObject payload) => _$this._payload = payload;

  JsonObject _state;
  JsonObject get state => _$this._state;
  set state(JsonObject state) => _$this._state = state;

  ServerEventType _serverEventType;
  ServerEventType get serverEventType => _$this._serverEventType;
  set serverEventType(ServerEventType serverEventType) => _$this._serverEventType = serverEventType;

  DateTime _datetime;
  DateTime get datetime => _$this._datetime;
  set datetime(DateTime datetime) => _$this._datetime = datetime;

  bool _favorite;
  bool get favorite => _$this._favorite;
  set favorite(bool favorite) => _$this._favorite = favorite;

  ServerEventBuilder() {
    ServerEvent._initializeBuilder(this);
  }

  ServerEventBuilder get _$this {
    if (_$v != null) {
      _serverEventId = _$v.serverEventId;
      _action = _$v.action;
      _payload = _$v.payload;
      _state = _$v.state;
      _serverEventType = _$v.serverEventType;
      _datetime = _$v.datetime;
      _favorite = _$v.favorite;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServerEvent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ServerEvent;
  }

  @override
  void update(void Function(ServerEventBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ServerEvent build() {
    final _$result = _$v ??
        new _$ServerEvent._(
            serverEventId: serverEventId,
            action: action,
            payload: payload,
            state: state,
            serverEventType: serverEventType,
            datetime: datetime,
            favorite: favorite);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
