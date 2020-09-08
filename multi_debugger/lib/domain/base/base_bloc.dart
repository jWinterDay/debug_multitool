import 'package:flutter/material.dart';
import 'package:multi_debugger/app_globals.dart';

import 'package:multi_debugger/di/app_di.dart';

abstract class BaseBloc {
  AppGlobals get appGlobals => di.get<AppGlobals>();

  @mustCallSuper
  void init() {}

  @mustCallSuper
  void dispose() {}
}
