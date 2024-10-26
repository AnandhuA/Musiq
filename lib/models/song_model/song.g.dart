// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 0;

  @override
  Song read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Song(
      id: fields[0] as String?,
      name: fields[1] as String?,
      type: fields[2] as String?,
      year: fields[3] as String?,
      releaseDate: fields[4] as String?,
      duration: fields[5] as int?,
      label: fields[6] as String?,
      explicitContent: fields[7] as bool?,
      playCount: fields[8] as int?,
      language: fields[9] as String?,
      hasLyrics: fields[10] as bool?,
      lyricsId: fields[11] as dynamic,
      url: fields[12] as String?,
      copyright: fields[13] as String?,
      album: fields[14] as Album?,
      artists: fields[15] as Artists?,
      image: (fields[16] as List?)?.cast<Image>(),
      downloadUrl: (fields[17] as List?)?.cast<DownloadUrl>(),
      addedAt: fields[18] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.label)
      ..writeByte(7)
      ..write(obj.explicitContent)
      ..writeByte(8)
      ..write(obj.playCount)
      ..writeByte(9)
      ..write(obj.language)
      ..writeByte(10)
      ..write(obj.hasLyrics)
      ..writeByte(11)
      ..write(obj.lyricsId)
      ..writeByte(12)
      ..write(obj.url)
      ..writeByte(13)
      ..write(obj.copyright)
      ..writeByte(14)
      ..write(obj.album)
      ..writeByte(15)
      ..write(obj.artists)
      ..writeByte(16)
      ..write(obj.image)
      ..writeByte(17)
      ..write(obj.downloadUrl)
      ..writeByte(18)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
