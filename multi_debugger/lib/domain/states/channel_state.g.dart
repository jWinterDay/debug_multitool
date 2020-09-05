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
    return <Object>[];
  }

  @override
  ChannelState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new ChannelStateBuilder().build();
  }
}

class _$ChannelState extends ChannelState {
  factory _$ChannelState([void Function(ChannelStateBuilder) updates]) =>
      (new ChannelStateBuilder()..update(updates)).build();

  _$ChannelState._() : super._();

  @override
  ChannelState rebuild(void Function(ChannelStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  ChannelStateBuilder toBuilder() => new ChannelStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChannelState;
  }

  @override
  int get hashCode {
    return 843593885;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('ChannelState').toString();
  }
}

class ChannelStateBuilder implements Builder<ChannelState, ChannelStateBuilder> {
  _$ChannelState _$v;

  ChannelStateBuilder();

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
    final _$result = _$v ?? new _$ChannelState._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
