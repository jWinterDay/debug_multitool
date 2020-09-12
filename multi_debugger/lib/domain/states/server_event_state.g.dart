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
      'selectedEvents',
      serializers.serialize(object.selectedEvents,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltList, const [const FullType(ServerEvent)])
          ])),
    ];

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
        case 'selectedEvents':
          result.selectedEvents.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(ServerEvent)])
              ])));
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
  final BuiltMap<String, BuiltList<ServerEvent>> selectedEvents;

  factory _$ServerEventState([void Function(ServerEventStateBuilder) updates]) =>
      (new ServerEventStateBuilder()..update(updates)).build();

  _$ServerEventState._({this.events, this.selectedEvents}) : super._() {
    if (events == null) {
      throw new BuiltValueNullFieldError('ServerEventState', 'events');
    }
    if (selectedEvents == null) {
      throw new BuiltValueNullFieldError('ServerEventState', 'selectedEvents');
    }
  }

  @override
  ServerEventState rebuild(void Function(ServerEventStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  ServerEventStateBuilder toBuilder() => new ServerEventStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServerEventState && events == other.events && selectedEvents == other.selectedEvents;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, events.hashCode), selectedEvents.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ServerEventState')
          ..add('events', events)
          ..add('selectedEvents', selectedEvents))
        .toString();
  }
}

class ServerEventStateBuilder implements Builder<ServerEventState, ServerEventStateBuilder> {
  _$ServerEventState _$v;

  MapBuilder<String, BuiltList<ServerEvent>> _events;
  MapBuilder<String, BuiltList<ServerEvent>> get events =>
      _$this._events ??= new MapBuilder<String, BuiltList<ServerEvent>>();
  set events(MapBuilder<String, BuiltList<ServerEvent>> events) => _$this._events = events;

  MapBuilder<String, BuiltList<ServerEvent>> _selectedEvents;
  MapBuilder<String, BuiltList<ServerEvent>> get selectedEvents =>
      _$this._selectedEvents ??= new MapBuilder<String, BuiltList<ServerEvent>>();
  set selectedEvents(MapBuilder<String, BuiltList<ServerEvent>> selectedEvents) =>
      _$this._selectedEvents = selectedEvents;

  ServerEventStateBuilder() {
    ServerEventState._initializeBuilder(this);
  }

  ServerEventStateBuilder get _$this {
    if (_$v != null) {
      _events = _$v.events?.toBuilder();
      _selectedEvents = _$v.selectedEvents?.toBuilder();
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
      _$result = _$v ?? new _$ServerEventState._(events: events.build(), selectedEvents: selectedEvents.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'events';
        events.build();
        _$failedField = 'selectedEvents';
        selectedEvents.build();
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
