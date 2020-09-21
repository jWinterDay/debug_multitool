import 'package:flutter/widgets.dart';

abstract class BaseService {
  @mustCallSuper
  void init() {}

  @mustCallSuper
  void dispose() {}
}
