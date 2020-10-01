// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_event_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ServerEventState> _$serverEventStateSerializer = new _$ServerEventStateSerializer();

class _$ServerEventStateSerializer implements StructuredSerializer<ServerEventState> {
  @override
  final Iterable<Type> types = const [ServerEventState, _$ServerEventState];
  @override
  final String wireName = 'ServerEventState';

  @override
  Iterable<Object> serialize(Serializers serializers, ServerEventState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'events',
      serializers.serialize(object.events,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltList, const [const FullType(ServerEvent)])
          ])),
    ];
    if (object.channelIdForLastEvent != null) {
      result
        ..add('channelIdForLastEvent')
        ..add(serializers.serialize(object.channelIdForLastEvent, specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ServerEventState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ServerEventStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'events':
          result.events.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(ServerEvent)])
              ])));
          break;
        case 'channelIdForLastEvent':
          result.channelIdForLastEvent =
              serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ServerEventState extends ServerEventState {
  @override
  final BuiltMap<String, BuiltList<ServerEvent>> events;
  @override
  final String channelIdForLastEvent;

  factory _$ServerEventState([void Function(ServerEventStateBuilder) updates]) =>
      (new ServerEventStateBuilder()..update(updates)).build();

  _$ServerEventState._({this.events, this.channelIdForLastEvent}) : super._() {
    if (events == null) {
      throw new BuiltValueNullFieldError('ServerEventState', 'events');
    }
  }

  @override
  ServerEventState rebuild(void Function(ServerEventStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  ServerEventStateBuilder toBuilder() => new ServerEventStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServerEventState && events == other.events && channelIdForLastEvent == other.channelIdForLastEvent;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, events.hashCode), channelIdForLastEvent.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ServerEventState')
          ..add('events', events)
          ..add('channelIdForLastEvent', channelIdForLastEvent))
        .toString();
  }
}

class ServerEventStateBuilder implements Builder<ServerEventState, ServerEventStateBuilder> {
  _$ServerEventState _$v;

  MapBuilder<String, BuiltList<ServerEvent>> _events;
  MapBuilder<String, BuiltList<ServerEvent>> get events =>
      _$this._events ??= new MapBuilder<String, BuiltList<ServerEvent>>();
  set events(MapBuilder<String, BuiltList<ServerEvent>> events) => _$this._events = events;

  String _channelIdForLastEvent;
  String get channelIdForLastEvent => _$this._channelIdForLastEvent;
  set channelIdForLastEvent(String channelIdForLastEvent) => _$this._channelIdForLastEvent = channelIdForLastEvent;

  ServerEventStateBuilder() {
    ServerEventState._initializeBuilder(this);
  }

  ServerEventStateBuilder get _$this {
    if (_$v != null) {
      _events = _$v.events?.toBuilder();
      _channelIdForLastEvent = _$v.channelIdForLastEvent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ServerEventState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ServerEventState;
  }

  @override
  void update(void Function(ServerEventStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ServerEventState build() {
    _$ServerEventState _$result;
    try {
      _$result = _$v ?? new _$ServerEventState._(events: events.build(), channelIdForLastEvent: channelIdForLastEvent);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'events';
        events.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError('ServerEventState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
