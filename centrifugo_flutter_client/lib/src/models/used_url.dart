import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'used_url.g.dart';

@HiveType(typeId: 2)
class UsedUrl extends HiveObject with EquatableMixin {
  UsedUrl({
    this.name,
    this.isPermanent = false,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  bool isPermanent;

  @override
  String toString() {
    return '$name: $isPermanent';
  }

  @override
  List<Object> get props => <Object>[name, isPermanent];
}
