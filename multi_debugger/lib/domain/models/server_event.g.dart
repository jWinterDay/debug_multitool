// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ServerEvent extends ServerEvent {
  @override
  final String action;
  @override
  final JsonObject payload;
  @override
  final JsonObject state;
  @override
  final ServerEventType serverEventType;

  factory _$ServerEvent([void Function(ServerEventBuilder) updates]) =>
      (new ServerEventBuilder()..update(updates)).build();

  _$ServerEvent._({this.action, this.payload, this.state, this.serverEventType}) : super._() {
    if (action == null) {
      throw new BuiltValueNullFieldError('ServerEvent', 'action');
    }
    if (serverEventType == null) {
      throw new BuiltValueNullFieldError('ServerEvent', 'serverEventType');
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
        action == other.action &&
        payload == other.payload &&
        state == other.state &&
        serverEventType == other.serverEventType;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, action.hashCode), payload.hashCode), state.hashCode), serverEventType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ServerEvent')
          ..add('action', action)
          ..add('payload', payload)
          ..add('state', state)
          ..add('serverEventType', serverEventType))
        .toString();
  }
}

class ServerEventBuilder implements Builder<ServerEvent, ServerEventBuilder> {
  _$ServerEvent _$v;

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

  ServerEventBuilder() {
    ServerEvent._initializeBuilder(this);
  }

  ServerEventBuilder get _$this {
    if (_$v != null) {
      _action = _$v.action;
      _payload = _$v.payload;
      _state = _$v.state;
      _serverEventType = _$v.serverEventType;
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
    final _$result =
        _$v ?? new _$ServerEvent._(action: action, payload: payload, state: state, serverEventType: serverEventType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
