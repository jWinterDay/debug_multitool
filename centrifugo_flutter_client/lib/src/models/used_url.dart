import 'package:hive/hive.dart';

part 'used_url.g.dart';

@HiveType(typeId: 1)
class UsedUrl extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isPermanent;

  @override
  String toString() {
    return '$name: $isPermanent';
  }
}
