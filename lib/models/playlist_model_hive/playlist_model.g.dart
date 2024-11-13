// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistModelHiveAdapter extends TypeAdapter<PlaylistModelHive> {
  @override
  final int typeId = 7;

  @override
  PlaylistModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistModelHive(
      id: fields[0] as int,
      name: fields[1] as String,
      songList: (fields[2] as List).cast<Song>(),
      imagePath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistModelHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.songList)
      ..writeByte(3)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
