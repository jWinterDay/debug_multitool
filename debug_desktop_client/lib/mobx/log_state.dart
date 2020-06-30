import 'package:debug_desktop_client/mobx/log.dart';
import 'package:debug_desktop_client/tools/uikit.dart';
import 'package:flutter/widgets.dart' show Color;
import 'package:mobx/mobx.dart';

part 'log_state.g.dart';

class LogState = _LogState with _$LogState;

abstract class _LogState with Store {
  _LogState(this.log);

  final Log log;

  @observable
  bool isFavorite = false;

  String get viewedText {
    return log.enabled ? '${log.id}) ${log.datetime} > ${log.action}' : log.action;
  }

  Color get color {
    switch (log.action) {
      case 'connect':
        return MyColors.primary.withOpacity(0.1);

      case 'disconnect':
        return MyColors.blue.withOpacity(0.1);
      default:
        return MyColors.gray_e5e5e5;
    }
  }

  @action
  void setFavorite() {
    isFavorite = !isFavorite;
  }
}
