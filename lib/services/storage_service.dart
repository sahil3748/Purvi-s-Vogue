import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import '../config/appwrite_config.dart';

class StorageService {
  late final Storage _storage;
  final ImagePicker _picker = ImagePicker();

  StorageService() {
    final client = AppwriteConfig.getClient();
    _storage = Storage(client);
  }

  Future<String?> pickAndUploadImage(String folder) async {
    if (kIsWeb) {
      throw Exception('Image upload is not allowed in web version');
    }

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final bytes = await image.readAsBytes();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String fileId = '$folder-$timestamp';

      final result = await _storage.createFile(
        bucketId: AppwriteConfig.storageBucketId,
        fileId: fileId,
        file: InputFile.fromBytes(
          bytes: bytes,
          filename: image.name,
        ),
      );

      // Get the file view URL
      final String fileUrl =
          '${AppwriteConfig.endpoint}/storage/buckets/${AppwriteConfig.storageBucketId}/files/${result.$id}/view';
      return fileUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    if (kIsWeb) {
      throw Exception('Image deletion is not allowed in web version');
    }

    try {
      // Extract fileId from the URL
      final uri = Uri.parse(imageUrl);
      final fileId = uri.pathSegments.last;

      await _storage.deleteFile(
        bucketId: AppwriteConfig.storageBucketId,
        fileId: fileId,
      );
    } catch (e) {
      print('Error deleting image: $e');
    }
  }
}
