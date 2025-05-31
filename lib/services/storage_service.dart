import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:purvis_vogue/config/appwrite_config.dart';

class StorageService {
  late final Storage _storage;
  
  StorageService() {
    final client = AppwriteConfig.getClient();
    _storage = Storage(client);
  }

  // Upload a file
  Future<String> uploadFile({
    required String bucketId,
    required String fileId,
    required Uint8List fileBytes,
    List<String>? permissions,
  }) async {
    try {
      final result = await _storage.createFile(
        bucketId: bucketId,
        fileId: fileId,
        file: InputFile.fromBytes(bytes: fileBytes, filename: fileId),
        permissions: permissions,
      );
      return result.$id;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  // Delete a file
  Future<void> deleteFile({
    required String bucketId,
    required String fileId,
  }) async {
    try {
      await _storage.deleteFile(
        bucketId: bucketId,
        fileId: fileId,
      );
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  // Get file preview URL
  String getFilePreview({
    required String bucketId,
    required String fileId,
  }) {
    return _storage.getFilePreview(
      bucketId: bucketId,
      fileId: fileId,
    ).toString();
  }

  // Download file
  Future<Uint8List> downloadFile({
    required String bucketId,
    required String fileId,
  }) async {
    try {
      final response = await _storage.getFileDownload(
        bucketId: bucketId,
        fileId: fileId,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to download file: $e');
    }
  }

  // List files in a bucket
  Future<List> listFiles({
    required String bucketId,
  }) async {
    try {
      final response = await _storage.listFiles(
        bucketId: bucketId,
      );
      return response.files;
    } catch (e) {
      throw Exception('Failed to list files: $e');
    }
  }
} 