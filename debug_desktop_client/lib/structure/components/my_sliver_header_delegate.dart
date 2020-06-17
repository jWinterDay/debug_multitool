import 'package:flutter/cupertino.dart';

class MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const MySliverHeaderDelegate({
    @required this.child,
    this.minHeight = 56.0,
    this.maxHeight = 56.0,
  });

  final Widget child;
  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(MySliverHeaderDelegate oldDelegate) => false;
}

typedef SliverSizeableHeaderBuilder = Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverSizeableHeaderDelegate extends SliverPersistentHeaderDelegate {
  const SliverSizeableHeaderDelegate({
    @required this.builder,
    this.minHeight = 56.0,
    this.maxHeight = 56.0,
  });

  final SliverSizeableHeaderBuilder builder;
  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  bool shouldRebuild(SliverSizeableHeaderDelegate oldDelegate) => true;
}
