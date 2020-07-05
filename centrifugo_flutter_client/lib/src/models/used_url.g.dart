// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsedUrlAdapter extends TypeAdapter<UsedUrl> {
  @override
  final typeId = 1;

  @override
  UsedUrl read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsedUrl()
      ..name = fields[0] as String
      ..isPermanent = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, UsedUrl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isPermanent);
  }
}
