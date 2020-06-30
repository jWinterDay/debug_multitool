import 'package:debug_desktop_client/mobx/log.dart';
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

  @action
  void setFavorite() {
    isFavorite = !isFavorite;
  }
}
