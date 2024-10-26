// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadUrlAdapter extends TypeAdapter<DownloadUrl> {
  @override
  final int typeId = 2;

  @override
  DownloadUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadUrl(
      link: fields[0] as String,
      quality: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadUrl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.link)
      ..writeByte(1)
      ..write(obj.quality);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
