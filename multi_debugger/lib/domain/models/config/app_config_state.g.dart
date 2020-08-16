// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppConfigState> _$appConfigStateSerializer = new _$AppConfigStateSerializer();

class _$AppConfigStateSerializer implements StructuredSerializer<AppConfigState> {
  @override
  final Iterable<Type> types = const [AppConfigState, _$AppConfigState];
  @override
  final String wireName = 'AppConfigState';

  @override
  Iterable<Object> serialize(Serializers serializers, AppConfigState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.localSettings != null) {
      result
        ..add('localSettings')
        ..add(serializers.serialize(object.localSettings, specifiedType: const FullType(LocalSettingsState)));
    }
    return result;
  }

  @override
  AppConfigState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppConfigStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'localSettings':
          result.localSettings.replace(
              serializers.deserialize(value, specifiedType: const FullType(LocalSettingsState)) as LocalSettingsState);
          break;
      }
    }

    return result.build();
  }
}

class _$AppConfigState extends AppConfigState {
  @override
  final LocalSettingsState localSettings;

  factory _$AppConfigState([void Function(AppConfigStateBuilder) updates]) =>
      (new AppConfigStateBuilder()..update(updates)).build();

  _$AppConfigState._({this.localSettings}) : super._();

  @override
  AppConfigState rebuild(void Function(AppConfigStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  AppConfigStateBuilder toBuilder() => new AppConfigStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppConfigState && localSettings == other.localSettings;
  }

  @override
  int get hashCode {
    return $jf($jc(0, localSettings.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppConfigState')..add('localSettings', localSettings)).toString();
  }
}

class AppConfigStateBuilder implements Builder<AppConfigState, AppConfigStateBuilder> {
  _$AppConfigState _$v;

  LocalSettingsStateBuilder _localSettings;
  LocalSettingsStateBuilder get localSettings => _$this._localSettings ??= new LocalSettingsStateBuilder();
  set localSettings(LocalSettingsStateBuilder localSettings) => _$this._localSettings = localSettings;

  AppConfigStateBuilder() {
    AppConfigState._initializeBuilder(this);
  }

  AppConfigStateBuilder get _$this {
    if (_$v != null) {
      _localSettings = _$v.localSettings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppConfigState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppConfigState;
  }

  @override
  void update(void Function(AppConfigStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppConfigState build() {
    _$AppConfigState _$result;
    try {
      _$result = _$v ?? new _$AppConfigState._(localSettings: _localSettings?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'localSettings';
        _localSettings?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError('AppConfigState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
