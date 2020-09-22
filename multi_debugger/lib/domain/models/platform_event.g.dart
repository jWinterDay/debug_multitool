// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PlatformEvent> _$platformEventSerializer = new _$PlatformEventSerializer();

class _$PlatformEventSerializer implements StructuredSerializer<PlatformEvent> {
  @override
  final Iterable<Type> types = const [PlatformEvent, _$PlatformEvent];
  @override
  final String wireName = 'PlatformEvent';

  @override
  Iterable<Object> serialize(Serializers serializers, PlatformEvent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.type != null) {
      result..add('type')..add(serializers.serialize(object.type, specifiedType: const FullType(PlatformEventType)));
    }
    if (object.width != null) {
      result..add('width')..add(serializers.serialize(object.width, specifiedType: const FullType(int)));
    }
    if (object.height != null) {
      result..add('height')..add(serializers.serialize(object.height, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  PlatformEvent deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PlatformEventBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type =
              serializers.deserialize(value, specifiedType: const FullType(PlatformEventType)) as PlatformEventType;
          break;
        case 'width':
          result.width = serializers.deserialize(value, specifiedType: const FullType(int)) as int;
          break;
        case 'height':
          result.height = serializers.deserialize(value, specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$PlatformEvent extends PlatformEvent {
  @override
  final PlatformEventType type;
  @override
  final int width;
  @override
  final int height;

  factory _$PlatformEvent([void Function(PlatformEventBuilder) updates]) =>
      (new PlatformEventBuilder()..update(updates)).build();

  _$PlatformEvent._({this.type, this.width, this.height}) : super._();

  @override
  PlatformEvent rebuild(void Function(PlatformEventBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  PlatformEventBuilder toBuilder() => new PlatformEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlatformEvent && type == other.type && width == other.width && height == other.height;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, type.hashCode), width.hashCode), height.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PlatformEvent')..add('type', type)..add('width', width)..add('height', height))
        .toString();
  }
}

class PlatformEventBuilder implements Builder<PlatformEvent, PlatformEventBuilder> {
  _$PlatformEvent _$v;

  PlatformEventType _type;
  PlatformEventType get type => _$this._type;
  set type(PlatformEventType type) => _$this._type = type;

  int _width;
  int get width => _$this._width;
  set width(int width) => _$this._width = width;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  PlatformEventBuilder();

  PlatformEventBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _width = _$v.width;
      _height = _$v.height;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlatformEvent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PlatformEvent;
  }

  @override
  void update(void Function(PlatformEventBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PlatformEvent build() {
    final _$result = _$v ?? new _$PlatformEvent._(type: type, width: width, height: height);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
