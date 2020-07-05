import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'app_state.g.dart';

@HiveType(typeId: 0)
class AppState extends HiveObject with EquatableMixin {
  AppState({
    this.currentUrl = '',
    this.currentChannel = '',
  })  : assert(currentUrl != null),
        assert(currentChannel != null);

  @HiveField(0)
  String currentUrl;

  @HiveField(1)
  String currentChannel;

  @override
  String toString() {
    return 'currentUrl: $currentUrl, currentChannel: $currentChannel';
  }

  @override
  List<Object> get props => <Object>[currentUrl, currentChannel];
}
