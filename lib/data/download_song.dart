import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class DownloadSongRepo {
 static Future<void> downloadSong({
    required String downloadUrl,
    required String fileName,
  }) async {
    try {
      var status = await Permission.storage.status;

      if (status.isDenied || status.isRestricted) {
        status = await Permission.storage.request();
      }

      if (status.isPermanentlyDenied) {
        Fluttertoast.showToast(
            msg:
                "Storage permission permanently denied. Please enable it in settings.");
        await openAppSettings();
        return;
      }

 
      if (Platform.isAndroid &&
          await Permission.manageExternalStorage.isDenied) {
        Fluttertoast.showToast(msg: "Please enable manage external storage.");
        await openAppSettings();
        return;
      }

      if (status.isGranted) {
        Directory? directory = await getExternalStorageDirectory();
        String downloadPath = "${directory!.path}/Musiq/";

        Directory(downloadPath).createSync(recursive: true);

        final response = await http.get(Uri.parse(downloadUrl));
        if (response.statusCode == 200) {
          String filePath = '$downloadPath$fileName';

          File file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

          Fluttertoast.showToast(msg: "Download complete: $filePath");
          print("Download complete: $filePath");
        } else {
          print("Failed to download. Status code: ${response.statusCode}");
          Fluttertoast.showToast(
              msg: "Failed to download. Status code: ${response.statusCode}");
        }
      } else {
        print("Storage permission denied.");
        Fluttertoast.showToast(msg: "Storage permission denied.");
      }
    } catch (e) {
      print("Error downloading song: $e");
      Fluttertoast.showToast(msg: "Error downloading song: $e");
    }
  }

}
