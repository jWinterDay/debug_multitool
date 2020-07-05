import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'channel.g.dart';

@HiveType(typeId: 1)
class Channel extends HiveObject with EquatableMixin {
  Channel({
    this.name,
  });

  @HiveField(0)
  String name;

  @override
  String toString() {
    return name;
  }

  @override
  List<Object> get props => <Object>[name];
}
