// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppStateAdapter extends TypeAdapter<AppState> {
  @override
  final typeId = 0;

  @override
  AppState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppState(
      currentUrl: fields[0] as String,
      currentChannel: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currentUrl)
      ..writeByte(1)
      ..write(obj.currentChannel);
  }
}
