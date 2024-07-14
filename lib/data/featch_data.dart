import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:musiq/models/song_model.dart';

Future<List<SongModel>?> fetchAllMusicFilesAndPrintMetadata() async {
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

      final metadata = await readMetadata(tempFile, getImage: true);
      Uint8List? imageBytes;
      if (metadata.pictures.isNotEmpty) {
        imageBytes = metadata.pictures.first.bytes;
      }
      SongModel model = SongModel(
        songUrls: downloadURL,
        album: metadata.album ?? "unknown",
        duration: metadata.duration ?? const Duration(minutes: 1),
        artist: metadata.artist ?? "unknown",
        imgFile: imageBytes,
      );

      musicModels.add(model);
    });

    return musicModels;
  } catch (e) {
    log('Error fetching music files: $e');
    return null;
  }
}
