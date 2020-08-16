// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_route.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppRoute extends AppRoute {
  @override
  final String route;
  @override
  final String payload;
  @override
  final String screenTitle;
  @override
  final Object context;
  @override
  final Object bundle;

  factory _$AppRoute([void Function(AppRouteBuilder) updates]) => (new AppRouteBuilder()..update(updates)).build();

  _$AppRoute._({this.route, this.payload, this.screenTitle, this.context, this.bundle}) : super._() {
    if (route == null) {
      throw new BuiltValueNullFieldError('AppRoute', 'route');
    }
  }

  @override
  AppRoute rebuild(void Function(AppRouteBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  AppRouteBuilder toBuilder() => new AppRouteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppRoute &&
        route == other.route &&
        payload == other.payload &&
        screenTitle == other.screenTitle &&
        context == other.context &&
        bundle == other.bundle;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc($jc(0, route.hashCode), payload.hashCode), screenTitle.hashCode), context.hashCode),
        bundle.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppRoute')
          ..add('route', route)
          ..add('payload', payload)
          ..add('screenTitle', screenTitle)
          ..add('context', context)
          ..add('bundle', bundle))
        .toString();
  }
}

class AppRouteBuilder implements Builder<AppRoute, AppRouteBuilder> {
  _$AppRoute _$v;

  String _route;
  String get route => _$this._route;
  set route(String route) => _$this._route = route;

  String _payload;
  String get payload => _$this._payload;
  set payload(String payload) => _$this._payload = payload;

  String _screenTitle;
  String get screenTitle => _$this._screenTitle;
  set screenTitle(String screenTitle) => _$this._screenTitle = screenTitle;

  Object _context;
  Object get context => _$this._context;
  set context(Object context) => _$this._context = context;

  Object _bundle;
  Object get bundle => _$this._bundle;
  set bundle(Object bundle) => _$this._bundle = bundle;

  AppRouteBuilder();

  AppRouteBuilder get _$this {
    if (_$v != null) {
      _route = _$v.route;
      _payload = _$v.payload;
      _screenTitle = _$v.screenTitle;
      _context = _$v.context;
      _bundle = _$v.bundle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppRoute other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppRoute;
  }

  @override
  void update(void Function(AppRouteBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppRoute build() {
    final _$result = _$v ??
        new _$AppRoute._(route: route, payload: payload, screenTitle: screenTitle, context: context, bundle: bundle);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
