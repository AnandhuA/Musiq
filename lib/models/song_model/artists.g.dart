// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtistsAdapter extends TypeAdapter<Artists> {
  @override
  final int typeId = 3;

  @override
  Artists read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artists(
      primary: (fields[0] as List?)?.cast<Primary>(),
      featured: (fields[1] as List?)?.cast<dynamic>(),
      all: (fields[2] as List?)?.cast<All>(),
    );
  }

  @override
  void write(BinaryWriter writer, Artists obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.primary)
      ..writeByte(1)
      ..write(obj.featured)
      ..writeByte(2)
      ..write(obj.all);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
