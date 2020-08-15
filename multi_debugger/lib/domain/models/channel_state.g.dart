// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChannelState> _$channelStateSerializer = new _$ChannelStateSerializer();

class _$ChannelStateSerializer implements StructuredSerializer<ChannelState> {
  @override
  final Iterable<Type> types = const [ChannelState, _$ChannelState];
  @override
  final String wireName = 'ChannelState';

  @override
  Iterable<Object> serialize(Serializers serializers, ChannelState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ChannelState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChannelStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ChannelState extends ChannelState {
  @override
  final String name;

  factory _$ChannelState([void Function(ChannelStateBuilder) updates]) =>
      (new ChannelStateBuilder()..update(updates)).build();

  _$ChannelState._({this.name}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('ChannelState', 'name');
    }
  }

  @override
  ChannelState rebuild(void Function(ChannelStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  ChannelStateBuilder toBuilder() => new ChannelStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChannelState && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(0, name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChannelState')..add('name', name)).toString();
  }
}

class ChannelStateBuilder implements Builder<ChannelState, ChannelStateBuilder> {
  _$ChannelState _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  ChannelStateBuilder();

  ChannelStateBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChannelState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ChannelState;
  }

  @override
  void update(void Function(ChannelStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChannelState build() {
    final _$result = _$v ?? new _$ChannelState._(name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
