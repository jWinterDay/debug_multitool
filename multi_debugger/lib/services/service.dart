import 'package:flutter/widgets.dart';

abstract class Service {
  @mustCallSuper
  void init() {}

  @mustCallSuper
  void dispose() {}
}
