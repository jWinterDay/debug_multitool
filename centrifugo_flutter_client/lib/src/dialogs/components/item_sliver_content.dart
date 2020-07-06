import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemSliverContent extends StatelessWidget {
  const ItemSliverContent({
    Key key,
    @required this.name,
    @required this.isPermanent,
    this.onDeleteCallback,
  })  : assert(name != null),
        assert(isPermanent != null),
        super(key: key);

  final String name;
  final bool isPermanent;
  final VoidCallback onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: <Widget>[
          const Icon(Icons.ac_unit),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(name);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  name.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // delete
          if (!isPermanent)
            GestureDetector(
              onTap: onDeleteCallback == null ? null : () => onDeleteCallback(),
              child: const Icon(
                Icons.delete_sweep,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
