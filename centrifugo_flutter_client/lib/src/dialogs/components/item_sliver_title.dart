import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemSliverTitle extends StatelessWidget {
  const ItemSliverTitle({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }
}
