// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_settings_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LocalSettingsState> _$localSettingsStateSerializer = new _$LocalSettingsStateSerializer();

class _$LocalSettingsStateSerializer implements StructuredSerializer<LocalSettingsState> {
  @override
  final Iterable<Type> types = const [LocalSettingsState, _$LocalSettingsState];
  @override
  final String wireName = 'LocalSettingsState';

  @override
  Iterable<Object> serialize(Serializers serializers, LocalSettingsState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.enableRestLogging != null) {
      result
        ..add('enableRestLogging')
        ..add(serializers.serialize(object.enableRestLogging, specifiedType: const FullType(bool)));
    }
    if (object.rawloggerLevel != null) {
      result
        ..add('loggerLevel')
        ..add(serializers.serialize(object.rawloggerLevel, specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  LocalSettingsState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LocalSettingsStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'enableRestLogging':
          result.enableRestLogging = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          break;
        case 'loggerLevel':
          result.rawloggerLevel = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LocalSettingsState extends LocalSettingsState {
  @override
  final bool enableRestLogging;
  @override
  final String rawloggerLevel;

  factory _$LocalSettingsState([void Function(LocalSettingsStateBuilder) updates]) =>
      (new LocalSettingsStateBuilder()..update(updates)).build();

  _$LocalSettingsState._({this.enableRestLogging, this.rawloggerLevel}) : super._();

  @override
  LocalSettingsState rebuild(void Function(LocalSettingsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocalSettingsStateBuilder toBuilder() => new LocalSettingsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocalSettingsState &&
        enableRestLogging == other.enableRestLogging &&
        rawloggerLevel == other.rawloggerLevel;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, enableRestLogging.hashCode), rawloggerLevel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LocalSettingsState')
          ..add('enableRestLogging', enableRestLogging)
          ..add('rawloggerLevel', rawloggerLevel))
        .toString();
  }
}

class LocalSettingsStateBuilder implements Builder<LocalSettingsState, LocalSettingsStateBuilder> {
  _$LocalSettingsState _$v;

  bool _enableRestLogging;
  bool get enableRestLogging => _$this._enableRestLogging;
  set enableRestLogging(bool enableRestLogging) => _$this._enableRestLogging = enableRestLogging;

  String _rawloggerLevel;
  String get rawloggerLevel => _$this._rawloggerLevel;
  set rawloggerLevel(String rawloggerLevel) => _$this._rawloggerLevel = rawloggerLevel;

  LocalSettingsStateBuilder() {
    LocalSettingsState._initializeBuilder(this);
  }

  LocalSettingsStateBuilder get _$this {
    if (_$v != null) {
      _enableRestLogging = _$v.enableRestLogging;
      _rawloggerLevel = _$v.rawloggerLevel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocalSettingsState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LocalSettingsState;
  }

  @override
  void update(void Function(LocalSettingsStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LocalSettingsState build() {
    final _$result =
        _$v ?? new _$LocalSettingsState._(enableRestLogging: enableRestLogging, rawloggerLevel: rawloggerLevel);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
