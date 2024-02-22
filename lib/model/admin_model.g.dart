// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminEntryAdapter extends TypeAdapter<AdminEntry> {
  @override
  final int typeId = 1;

  @override
  AdminEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminEntry(
      name: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
    )..id = fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, AdminEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
