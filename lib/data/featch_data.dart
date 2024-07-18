import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:musiq/models/song_model.dart';

Future<List<SongModel>?> fetchAllMusicFilesAndPrintMetadata() async {
  List<SongModel> musicModels = [];

  try {
    // if (Platform.isWindows) {
    //   log("message");
    //   var status = await Permission.storage.request();
    //   print(status);
    //   if (!status.isGranted) {
    //     throw Exception('Storage permission is required to access files');
    //   }
    // }

    FirebaseStorage storage = FirebaseStorage.instance;

    Reference storageRef = storage.ref().child('musiq');

    ListResult result = await storageRef.listAll();
    print(result.items.length);
    await Future.forEach(result.items, (Reference ref) async {
      log("message1");
      String downloadURL = await ref.getDownloadURL();
      Reference fileRef = storage.refFromURL(downloadURL);
      final tempDir = await Directory.systemTemp.createTemp();
      final fileName = downloadURL.split('/').last;
      final tempFilePath = '${tempDir.path}/$fileName';

      File tempFile = File(tempFilePath);
      log('Temporary file path: $tempFilePath');
      log("message2");
      await fileRef.writeToFile(tempFile);

      // // Option 1: Using File.setPermissions (for targeted permission)
      // if (Platform.isWindows) {
      //   await tempFile.setPermissions(FileMode.read);
      // }

      // // Option 2: Using permission_handler (for broader storage permission)
      // // (Requires adding permission_handler to pubspec.yaml)
      // if (Platform.isAndroid || Platform.isIOS) {
      //   final status = await Permission.storage.request();
      //   if (!status.isGranted) {
      //     throw Exception('Storage permission is required to access files');
      //   }
      // }

      final metadata = await readMetadata(tempFile, getImage: true);
      Uint8List? imageBytes;
      if (metadata.pictures.isNotEmpty) {
        imageBytes = metadata.pictures.first.bytes;
      }
      SongModel model = SongModel(
        songUrls: downloadURL,
        movie: metadata.album ?? "unknown",
        songName: metadata.title ?? "unknown",
        duration: metadata.duration ?? const Duration(minutes: 1),
        artist: metadata.artist ?? "unknown",
        imgFile: imageBytes,
        language: metadata.language ?? "unknown",
        lyrics: metadata.lyrics ?? "unknown",
      );

      musicModels.add(model);
      log(musicModels.toString());
    });

    log(musicModels.toString());
    return musicModels;
  } catch (e) {
    log('Error fetching music files: $e');
    return null;
  }
}
