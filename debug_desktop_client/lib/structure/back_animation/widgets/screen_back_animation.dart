import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:debug_desktop_client/structure/back_animation/utils/back_animation_manager.dart';

/// [AppBackAnimManager]
/// [CoolRoute]
class ScreenBackAnimation extends StatefulWidget {
  const ScreenBackAnimation({
    @required this.child,
    this.routeTopPadding = 0.0,
    this.needForciblyAnimation = false, // if widget used without CoolRoute but we need back animation
  })  : assert(child != null),
        assert(routeTopPadding != null),
        assert(needForciblyAnimation != null);

  final Widget child;
  final double routeTopPadding;
  final bool needForciblyAnimation;

  @override
  _ScreenBackAnimationState createState() => _ScreenBackAnimationState();
}

class _ScreenBackAnimationState extends State<ScreenBackAnimation> with TickerProviderStateMixin {
  AppBackAnimManager _appBackAnim;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _appBackAnim = AppBackAnimManager(
          this,
          routeTopPadding: widget.routeTopPadding,
          needForciblyAnimation: widget.needForciblyAnimation,
        );
      });
    });
  }

  @override
  void dispose() {
    _appBackAnim?.dispose(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_appBackAnim?.animation == null) {
      return Container();
    } // widget.child;

    return AnimatedBuilder(
      animation: _appBackAnim.animation,
      builder: (_, __) {
        final double radius = _appBackAnim.appRadius;

        return SlideTransition(
          position: _appBackAnim.offsetAnimation,
          child: ScaleTransition(
            scale: _appBackAnim.animation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
