// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageAdapter extends TypeAdapter<Image> {
  @override
  final int typeId = 1;

  @override
  Image read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Image(
      imageUrl: fields[0] as String,
      quality: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Image obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.quality);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
