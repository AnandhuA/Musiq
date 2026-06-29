import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
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
      var status = await _downloadPermissionStatus();

      if (status.isDenied || status.isRestricted) {
        status = await _requestDownloadPermission();
      }

      if (status.isPermanentlyDenied) {
        if (defaultTargetPlatform != TargetPlatform.windows) {
          Fluttertoast.showToast(
              msg:
                  "Storage permission permanently denied. Please enable it in settings.");
        }
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
          if (defaultTargetPlatform != TargetPlatform.windows) {
            Fluttertoast.showToast(msg: "Download complete: $filePath");
          }
          print("Download complete: $filePath");
        } else {
          print("Failed to download. Status code: ${response.statusCode}");
          if (defaultTargetPlatform != TargetPlatform.windows) {
            Fluttertoast.showToast(
                msg: "Failed to download. Status code: ${response.statusCode}");
          }
        }
      } else {
        print("Storage permission denied.");
        if (defaultTargetPlatform != TargetPlatform.windows) {
          Fluttertoast.showToast(msg: "Storage permission denied.");
        }
      }
    } catch (e) {
      print("Error downloading song: $e");
      if (defaultTargetPlatform != TargetPlatform.windows) {
        Fluttertoast.showToast(msg: "Error downloading song: $e");
      }
    }
  }

  static Future<PermissionStatus> _downloadPermissionStatus() async {
    if (!Platform.isAndroid) {
      return Permission.storage.status;
    }

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      return Permission.audio.status;
    }
    return Permission.storage.status;
  }

  static Future<PermissionStatus> _requestDownloadPermission() async {
    if (!Platform.isAndroid) {
      return Permission.storage.request();
    }

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      return Permission.audio.request();
    }
    return Permission.storage.request();
  }
}
