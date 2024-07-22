
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:musiq/models/song_model.dart';

Future<List<SongModel>?> fetchBasicSongMetadata() async {
  List<SongModel> musicModels = [];

  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child('musiq');
    ListResult result = await storageRef.listAll();

    await Future.forEach(result.items, (Reference ref) async {
      String downloadURL = await ref.getDownloadURL();
      Reference fileRef = storage.refFromURL(downloadURL);
      final tempDir = await Directory.systemTemp.createTemp();
      final fileName = downloadURL.split('/').last;
      final tempFilePath = '${tempDir.path}/$fileName';
      File tempFile = File(tempFilePath);
      await fileRef.writeToFile(tempFile);

      final metadata =
          await readMetadata(tempFile, getImage: false); // Don't fetch images
      SongModel model = SongModel(
        songUrls: downloadURL,
        movie: metadata.album ?? "unknown",
        songName: metadata.title ?? "unknown",
        duration: metadata.duration ?? const Duration(minutes: 1),
        artist: metadata.artist ?? "unknown",
        imgFile: null, // No image loaded here
        language: metadata.language ?? "unknown",
        lyrics: metadata.lyrics ?? "unknown",
      );

      musicModels.add(model);
    });

    return musicModels;
  } catch (e) {
    log('Error fetching music files: $e');
    return null;
  }
}

Future<void> loadSong(SongModel song) async {
  try {
    // Simulating some delay to load song details
    await Future.delayed(Duration(seconds: 1));
  } catch (e) {
    log('Error loading song details: $e');
  }
}

Future<void> loadSongImage(SongModel song) async {
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference fileRef = storage.refFromURL(song.songUrls);
    final tempDir = await Directory.systemTemp.createTemp();
    final fileName = song.songUrls.split('/').last;
    final tempFilePath = '${tempDir.path}/$fileName';
    File tempFile = File(tempFilePath);
    await fileRef.writeToFile(tempFile);

    final metadata = await readMetadata(tempFile, getImage: true);
    Uint8List? imageBytes;
    if (metadata.pictures.isNotEmpty) {
      imageBytes = metadata.pictures.first.bytes;
      song.imgFile = imageBytes;
    }
  } catch (e) {
    log('Error loading image for song ${song.songName}: $e');
  }
}
