import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class UsedUrl {
  @HiveField(0)
  String name;

  @HiveField(1)
  int isPermanent;

  @override
  String toString() {
    return '$name: $isPermanent';
  }
}
