import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../networking/client/api_client.dart';

class FileDownloadService {
  final ApiClient _apiClient;

  FileDownloadService(this._apiClient);

  /// Downloads a file from the given [url] and saves it with [fileName].
  /// On Android, it saves to the Downloads directory.
  /// On iOS, it saves to the Application Documents directory.
  /// Returns the saved file path if successful, otherwise an empty string.
  Future<String> downloadFile(String url, String fileName, {void Function(int received, int total)? onReceiveProgress}) async {
    try {
      // Demander la permission de stockage
      if (Platform.isAndroid) {
        // On Android 11+, writing to public Download directory via File API requires manageExternalStorage
        var manageStatus = await Permission.manageExternalStorage.status;
        if (!manageStatus.isGranted) {
          manageStatus = await Permission.manageExternalStorage.request();
        }
        
        // On older Android versions, we need standard storage permission
        var storageStatus = await Permission.storage.status;
        if (!storageStatus.isGranted) {
          storageStatus = await Permission.storage.request();
        }

        if (!manageStatus.isGranted && !storageStatus.isGranted) {
           throw Exception("PERMISSION_DENIED");
        }
      } else {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
           throw Exception("PERMISSION_DENIED");
        }
      }

      String filePath;
      if (Platform.isAndroid) {
        String downloadsDir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOAD,
        );
        String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        filePath = '$downloadsDir/${timestamp}_$fileName';
      } else if (Platform.isIOS) {
        Directory appDocumentsDir = await getApplicationDocumentsDirectory();
        String appDocumentsPath = appDocumentsDir.path;
        filePath = '$appDocumentsPath/$fileName';
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      // Lancement du téléchargement
      try {
        await _apiClient.downloadFile(url, filePath, onReceiveProgress: onReceiveProgress);
      } catch (e) {
        if (e.toString().contains('Operation not permitted') || e.toString().contains('PathAccessException') || e.toString().contains('OS Error')) {
          debugPrint("Failed to write to public directory. Falling back to scoped storage. Error: $e");
          if (Platform.isAndroid) {
            Directory? scopedDir = await getExternalStorageDirectory();
            if (scopedDir != null) {
              String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
              filePath = '${scopedDir.path}/${timestamp}_$fileName';
              await _apiClient.downloadFile(url, filePath, onReceiveProgress: onReceiveProgress);
            } else {
              rethrow;
            }
          } else {
            rethrow;
          }
        } else {
          rethrow;
        }
      }

      return filePath;
    } catch (e) {
      debugPrint("Erreur lors du téléchargement : $e");
      if (e.toString().contains("PERMISSION_DENIED")) {
        return "PERMISSION_DENIED";
      }
      return "";
    }
  }
}
