// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApplicationDataAdapter extends TypeAdapter<ApplicationData> {
  @override
  final int typeId = 0;

  @override
  ApplicationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApplicationData(
      appName: fields[1] as String,
      appId: fields[0] as String,
      icon: fields[2] as Uint8List?,
      usageLimit: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ApplicationData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.appId)
      ..writeByte(1)
      ..write(obj.appName)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.usageLimit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
