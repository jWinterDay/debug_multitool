// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final ChannelState channelState;
  @override
  final AppConfigState appConfigState;

  factory _$AppState([void Function(AppStateBuilder) updates]) => (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.channelState, this.appConfigState}) : super._() {
    if (channelState == null) {
      throw new BuiltValueNullFieldError('AppState', 'channelState');
    }
    if (appConfigState == null) {
      throw new BuiltValueNullFieldError('AppState', 'appConfigState');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState && channelState == other.channelState && appConfigState == other.appConfigState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, channelState.hashCode), appConfigState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('channelState', channelState)
          ..add('appConfigState', appConfigState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  ChannelStateBuilder _channelState;
  ChannelStateBuilder get channelState => _$this._channelState ??= new ChannelStateBuilder();
  set channelState(ChannelStateBuilder channelState) => _$this._channelState = channelState;

  AppConfigStateBuilder _appConfigState;
  AppConfigStateBuilder get appConfigState => _$this._appConfigState ??= new AppConfigStateBuilder();
  set appConfigState(AppConfigStateBuilder appConfigState) => _$this._appConfigState = appConfigState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _channelState = _$v.channelState?.toBuilder();
      _appConfigState = _$v.appConfigState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ?? new _$AppState._(channelState: channelState.build(), appConfigState: appConfigState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'channelState';
        channelState.build();
        _$failedField = 'appConfigState';
        appConfigState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError('AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
