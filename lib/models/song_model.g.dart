// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongModelAdapter extends TypeAdapter<SongModel> {
  @override
  final int typeId = 1;

  @override
  SongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongModel(
      id: fields[0] as String,
      type: fields[1] as String,
      album: fields[2] as String,
      year: fields[3] as int,
      duration: fields[4] as int,
      language: fields[5] as String,
      genre: fields[6] as String,
      is320Kbps: fields[7] as bool,
      hasLyrics: fields[8] as bool,
      lyricsSnippet: fields[9] as String,
      releaseDate: fields[10] as String,
      albumId: fields[11] as String,
      subtitle: fields[12] as String,
      title: fields[13] as String,
      artist: fields[14] as String,
      albumArtist: fields[15] as String,
      imageUrl: fields[16] as String,
      permaUrl: fields[17] as String,
      url: fields[18] as String,
      addedAt: fields[19] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SongModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.album)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.genre)
      ..writeByte(7)
      ..write(obj.is320Kbps)
      ..writeByte(8)
      ..write(obj.hasLyrics)
      ..writeByte(9)
      ..write(obj.lyricsSnippet)
      ..writeByte(10)
      ..write(obj.releaseDate)
      ..writeByte(11)
      ..write(obj.albumId)
      ..writeByte(12)
      ..write(obj.subtitle)
      ..writeByte(13)
      ..write(obj.title)
      ..writeByte(14)
      ..write(obj.artist)
      ..writeByte(15)
      ..write(obj.albumArtist)
      ..writeByte(16)
      ..write(obj.imageUrl)
      ..writeByte(17)
      ..write(obj.permaUrl)
      ..writeByte(18)
      ..write(obj.url)
      ..writeByte(19)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
