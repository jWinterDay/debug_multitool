import 'package:flutter/widgets.dart';

const double _kBorderRadius = 12.0;
const double _kMaxZoom = 0.9;
const double _kMaxZoomRemaining = 1.0 - _kMaxZoom;
const double _kAppAnimAndRouteOffset = 15.0;
const int _kHomeId = 0; // root app back anim widget

/// back widget animation
/// [CoolRoute]
/// [ScreenBackAnimation]
/// first item in _list - home screen
class AppBackAnimManager {
  AppBackAnimManager(
    this.state, {
    @required this.routeTopPadding,
    this.needForciblyAnimation,
  })  : assert(state != null),
        assert(routeTopPadding != null) {
    // instance id
    _id = _list.length;
    _list.add(this);

    _screenSize = MediaQuery.of(state.context).size;
    _kRouteOffset = routeTopPadding / _screenSize.height;

    // controller
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: state);

    // simple animation
    _tween = Tween<double>(begin: 1.0, end: 1.0);
    _animation = _tween.animate(_controller);

    // offset animation
    _offsetTween = Tween<Offset>(begin: Offset.zero, end: Offset.zero);
    _offsetAnimation = _offsetTween.animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );
  }

  // params
  final TickerProviderStateMixin state;
  final double routeTopPadding;
  final bool needForciblyAnimation;

  int _id;
  Size _screenSize;
  double _kRouteOffset;
  bool _disposed = false;

  static final List<AppBackAnimManager> _list = [];
  static double getRouteTopPadding(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return _kMaxZoomRemaining * size.height / 2 + _kAppAnimAndRouteOffset;
  }

  static AppBackAnimManager get prevInstance {
    return _list[_list.length - 1];
  }

  static List<AppBackAnimManager> get prevInstancesList {
    return _list.sublist(0, _list.length);
  }

  static List<AppBackAnimManager> get prevWorkList {
    if (prevInstance.needForciblyAnimation) {
      return prevInstancesList;
    }

    return [prevInstance];
  }

  static void animatePrevToInitialState() {
    _list.sublist(0, _list.length - 1).where((AppBackAnimManager manager) {
      return !manager._disposed;
    }).forEach((AppBackAnimManager manager) {
      manager._tween.end = 1.0;
      manager._controller.reset();
      manager._controller.forward();
    });
  }

  // controller
  AnimationController _controller;

  // simple animation
  Animation<double> _animation;
  Animation<double> get animation => _animation;
  Tween<double> _tween;

  // offset animation
  Animation<Offset> _offsetAnimation;
  Animation<Offset> get offsetAnimation => _offsetAnimation;
  Tween<Offset> _offsetTween;

  // corner radius
  double get appRadius => 10 * _kBorderRadius * (1 - _animation.value);

  void dispose(TickerProviderStateMixin state) {
    _disposed = true;
    _controller?.dispose();
    _list.removeWhere((AppBackAnimManager element) => element.state == state);
  }

  double _progress(double val) => -1 * _kMaxZoomRemaining * val + 1.0;
  double _offsetProgress(double val) => -1 * _kRouteOffset * val;

  void progress(BuildContext context, double val) {
    if (_disposed) {
      return;
    }

    final double progress = _progress(val);

    // simple
    _tween.begin = _tween.end;
    _tween.end = _progress(val);

    // offset
    if (_id != _kHomeId) {
      _offsetTween.begin = _offsetTween.end;
      _offsetTween.end = Offset(0.0, _offsetProgress(val));
    }

    _controller.animateTo(progress);
  }
}
