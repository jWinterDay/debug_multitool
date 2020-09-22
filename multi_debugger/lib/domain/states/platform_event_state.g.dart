// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_event_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PlatformEventState> _$platformEventStateSerializer = new _$PlatformEventStateSerializer();

class _$PlatformEventStateSerializer implements StructuredSerializer<PlatformEventState> {
  @override
  final Iterable<Type> types = const [PlatformEventState, _$PlatformEventState];
  @override
  final String wireName = 'PlatformEventState';

  @override
  Iterable<Object> serialize(Serializers serializers, PlatformEventState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'platformEvent',
      serializers.serialize(object.platformEvent, specifiedType: const FullType(PlatformEvent)),
    ];

    return result;
  }

  @override
  PlatformEventState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PlatformEventStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'platformEvent':
          result.platformEvent
              .replace(serializers.deserialize(value, specifiedType: const FullType(PlatformEvent)) as PlatformEvent);
          break;
      }
    }

    return result.build();
  }
}

class _$PlatformEventState extends PlatformEventState {
  @override
  final PlatformEvent platformEvent;

  factory _$PlatformEventState([void Function(PlatformEventStateBuilder) updates]) =>
      (new PlatformEventStateBuilder()..update(updates)).build();

  _$PlatformEventState._({this.platformEvent}) : super._() {
    if (platformEvent == null) {
      throw new BuiltValueNullFieldError('PlatformEventState', 'platformEvent');
    }
  }

  @override
  PlatformEventState rebuild(void Function(PlatformEventStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlatformEventStateBuilder toBuilder() => new PlatformEventStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlatformEventState && platformEvent == other.platformEvent;
  }

  @override
  int get hashCode {
    return $jf($jc(0, platformEvent.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PlatformEventState')..add('platformEvent', platformEvent)).toString();
  }
}

class PlatformEventStateBuilder implements Builder<PlatformEventState, PlatformEventStateBuilder> {
  _$PlatformEventState _$v;

  PlatformEventBuilder _platformEvent;
  PlatformEventBuilder get platformEvent => _$this._platformEvent ??= new PlatformEventBuilder();
  set platformEvent(PlatformEventBuilder platformEvent) => _$this._platformEvent = platformEvent;

  PlatformEventStateBuilder();

  PlatformEventStateBuilder get _$this {
    if (_$v != null) {
      _platformEvent = _$v.platformEvent?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlatformEventState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PlatformEventState;
  }

  @override
  void update(void Function(PlatformEventStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PlatformEventState build() {
    _$PlatformEventState _$result;
    try {
      _$result = _$v ?? new _$PlatformEventState._(platformEvent: platformEvent.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'platformEvent';
        platformEvent.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError('PlatformEventState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
