import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppWriteService {
  late final Storage _storage;
  late final String _bucketId;

  AppWriteService() {
    final client = Client()
      ..setEndpoint(
          'YOUR_APPWRITE_ENDPOINT') // Replace with your AppWrite endpoint
      ..setProject('YOUR_PROJECT_ID'); // Replace with your project ID

    _storage = Storage(client);
    _bucketId = 'YOUR_BUCKET_ID'; // Replace with your bucket ID
  }

  // Upload an image and return its URL
  Future<String> uploadImage(String fileName, Uint8List fileData) async {
    try {
      final file = await _storage.createFile(
        bucketId: _bucketId,
        fileId: ID.unique(),
        file: InputFile.fromBytes(
          bytes: fileData,
          filename: fileName,
        ),
      );

      return getFileViewUrl(file.$id);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Delete an image
  Future<void> deleteImage(String fileId) async {
    try {
      await _storage.deleteFile(
        bucketId: _bucketId,
        fileId: fileId,
      );
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  // Get the URL for viewing a file
  String getFileViewUrl(String fileId) {
    return 'YOUR_APPWRITE_ENDPOINT/storage/buckets/$_bucketId/files/$fileId/view';
  }

  // List all images in a directory
  Future<List<models.File>> listImages({String? path}) async {
    try {
      final result = await _storage.listFiles(
        bucketId: _bucketId,
        queries: path != null ? [Query.search('path', path)] : null,
      );

      return result.files;
    } catch (e) {
      throw Exception('Failed to list images: $e');
    }
  }

  // Get file information
  Future<models.File> getFile(String fileId) async {
    try {
      return await _storage.getFile(
        bucketId: _bucketId,
        fileId: fileId,
      );
    } catch (e) {
      throw Exception('Failed to get file: $e');
    }
  }
}
