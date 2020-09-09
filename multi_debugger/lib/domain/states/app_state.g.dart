// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final AppConfigState appConfigState;
  @override
  final ChannelState channelState;
  @override
  final SavedUrlState savedUrlState;
  @override
  final ServerCommunicateServicesState serverCommunicateServicesState;

  factory _$AppState([void Function(AppStateBuilder) updates]) => (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.appConfigState, this.channelState, this.savedUrlState, this.serverCommunicateServicesState})
      : super._() {
    if (appConfigState == null) {
      throw new BuiltValueNullFieldError('AppState', 'appConfigState');
    }
    if (channelState == null) {
      throw new BuiltValueNullFieldError('AppState', 'channelState');
    }
    if (savedUrlState == null) {
      throw new BuiltValueNullFieldError('AppState', 'savedUrlState');
    }
    if (serverCommunicateServicesState == null) {
      throw new BuiltValueNullFieldError('AppState', 'serverCommunicateServicesState');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        appConfigState == other.appConfigState &&
        channelState == other.channelState &&
        savedUrlState == other.savedUrlState &&
        serverCommunicateServicesState == other.serverCommunicateServicesState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, appConfigState.hashCode), channelState.hashCode), savedUrlState.hashCode),
        serverCommunicateServicesState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('appConfigState', appConfigState)
          ..add('channelState', channelState)
          ..add('savedUrlState', savedUrlState)
          ..add('serverCommunicateServicesState', serverCommunicateServicesState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  AppConfigStateBuilder _appConfigState;
  AppConfigStateBuilder get appConfigState => _$this._appConfigState ??= new AppConfigStateBuilder();
  set appConfigState(AppConfigStateBuilder appConfigState) => _$this._appConfigState = appConfigState;

  ChannelStateBuilder _channelState;
  ChannelStateBuilder get channelState => _$this._channelState ??= new ChannelStateBuilder();
  set channelState(ChannelStateBuilder channelState) => _$this._channelState = channelState;

  SavedUrlStateBuilder _savedUrlState;
  SavedUrlStateBuilder get savedUrlState => _$this._savedUrlState ??= new SavedUrlStateBuilder();
  set savedUrlState(SavedUrlStateBuilder savedUrlState) => _$this._savedUrlState = savedUrlState;

  ServerCommunicateServicesState _serverCommunicateServicesState;
  ServerCommunicateServicesState get serverCommunicateServicesState => _$this._serverCommunicateServicesState;
  set serverCommunicateServicesState(ServerCommunicateServicesState serverCommunicateServicesState) =>
      _$this._serverCommunicateServicesState = serverCommunicateServicesState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _appConfigState = _$v.appConfigState?.toBuilder();
      _channelState = _$v.channelState?.toBuilder();
      _savedUrlState = _$v.savedUrlState?.toBuilder();
      _serverCommunicateServicesState = _$v.serverCommunicateServicesState;
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
      _$result = _$v ??
          new _$AppState._(
              appConfigState: appConfigState.build(),
              channelState: channelState.build(),
              savedUrlState: savedUrlState.build(),
              serverCommunicateServicesState: serverCommunicateServicesState);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'appConfigState';
        appConfigState.build();
        _$failedField = 'channelState';
        channelState.build();
        _$failedField = 'savedUrlState';
        savedUrlState.build();
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
