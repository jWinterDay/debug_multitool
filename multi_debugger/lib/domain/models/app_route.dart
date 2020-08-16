import 'package:built_value/built_value.dart';

part 'app_route.g.dart';

abstract class AppRoute implements Built<AppRoute, AppRouteBuilder> {
  AppRoute._();

  factory AppRoute([AppRouteBuilder updates(AppRouteBuilder buider)]) = _$AppRoute;

  String get route;

  @nullable
  String get payload;

  @nullable
  String get screenTitle;

  @BuiltValueField(serialize: false)
  @nullable
  Object get context;

  @BuiltValueField(serialize: false)
  @nullable
  Object get bundle;
}
