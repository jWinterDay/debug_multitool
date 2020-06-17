import 'package:flutter/material.dart';
import 'package:debug_desktop_client/structure/back_animation/widgets/screen_back_animation.dart';

import 'back_animation_manager.dart';

const Duration _kDuration = Duration(milliseconds: 300);

/// [AppBackAnimManager]
/// [ScreenBackAnimation]
class CoolRoute<T> extends PopupRoute<T> {
  CoolRoute({
    this.builder,
    this.barrierLabel,
    this.barrierColor,
    RouteSettings settings,
    this.resizeToAvoidBottomInset = true,
    this.dismissOnTap,
    this.callbackAfterClose,
    this.disableBodyScroll = false,
  })  : assert(disableBodyScroll != null),
        super(settings: settings);

  final WidgetBuilder builder;
  final bool resizeToAvoidBottomInset;
  final bool dismissOnTap;
  final VoidCallback callbackAfterClose;
  final bool disableBodyScroll;

  double topPadding;

  @override
  Duration get transitionDuration => _kDuration;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;
  @override
  final Color barrierColor;

  AnimationController _animationController;
  List<AppBackAnimManager> prevWorkList = AppBackAnimManager.prevWorkList;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(navigator.overlay);
    _animationController.duration = _kDuration;
    _animationController.addStatusListener((AnimationStatus listener) {
      switch (listener) {
        case AnimationStatus.dismissed:
          break;
        default:
      }
    });
    return _animationController;
  }

  void closeBottomSheetListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        callbackAfterClose();
        break;
      default:
    }
  }

  @override
  void dispose() {
    if (callbackAfterClose != null) callbackAfterClose();

    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    topPadding = AppBackAnimManager.getRouteTopPadding(context);

    return ScreenBackAnimation(
      routeTopPadding: topPadding,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: _BottomSheet<T>(
          prevWorkList: prevWorkList,
          route: this,
          disableBodyScroll: disableBodyScroll,
        ),
      ),
    );
  }
}

class _BottomSheet<T> extends StatefulWidget {
  _BottomSheet({
    Key key,
    this.prevWorkList,
    this.route,
    this.disableBodyScroll,
  }) : super(key: key);

  List<AppBackAnimManager> prevWorkList;
  final CoolRoute<T> route;
  final bool disableBodyScroll;

  @override
  _BottomSheetState<T> createState() {
    return _BottomSheetState<T>();
  }
}

class _BottomSheetState<T> extends State<_BottomSheet<T>> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.route.animation.addListener(() {
        final double val = widget.route.animation.value;

        widget.prevWorkList.forEach((AppBackAnimManager inst) {
          inst.progress(context, val);
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.route.animation,
      builder: (BuildContext context, Widget child) {
        final Size size = MediaQuery.of(context).size;

        return CustomSingleChildLayout(
          delegate: _ModalBottomSheetLayout(
            progress: widget.route.animation.value,
            bottomInset: 0,
            height: size.height - widget.route.topPadding,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
            child: BottomSheet(
              enableDrag: !widget.disableBodyScroll,
              animationController: widget.route._animationController,
              onClosing: () => Navigator.pop(context),
              builder: widget.route.builder,
            ),
          ),
        );
      },
    );
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout({
    this.progress,
    this.bottomInset,
    this.height,
  });

  final double progress;
  final double bottomInset;
  final double height;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: height,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - bottomInset - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress || bottomInset != oldDelegate.bottomInset;
  }
}
