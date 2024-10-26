// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrimaryAdapter extends TypeAdapter<Primary> {
  @override
  final int typeId = 5;

  @override
  Primary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Primary(
      id: fields[0] as String?,
      name: fields[1] as String?,
      role: fields[2] as String?,
      image: (fields[3] as List?)?.cast<Image>(),
      type: fields[4] as String?,
      url: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Primary obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrimaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
