import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../config/appwrite_config.dart';

class DataService {
  late final Databases _databases;
  late final String _databaseId;

  DataService() {
    final client = AppwriteConfig.getClient();
    _databases = Databases(client);
    _databaseId = AppwriteConfig.databaseId;
  }

  Future<List<Document>> getCollection(String collectionId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: collectionId,
      );
      return response.documents;
    } catch (e) {
      print('Error getting collection: $e');
      return [];
    }
  }

  Future<Document?> getDocument(String collectionId, String documentId) async {
    try {
      return await _databases.getDocument(
        databaseId: _databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }

  Future<Document?> addDocument(
      String collectionId, Map<String, dynamic> data) async {
    if (kIsWeb) {
      throw Exception('Write operations are not allowed in web version');
    }

    try {
      return await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: {
          ...data,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      print('Error adding document: $e');
      return null;
    }
  }

  Future<Document?> updateDocument(
      String collectionId, String documentId, Map<String, dynamic> data) async {
    if (kIsWeb) {
      throw Exception('Write operations are not allowed in web version');
    }

    try {
      return await _databases.updateDocument(
        databaseId: _databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: {
          ...data,
          'updated_at': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      print('Error updating document: $e');
      return null;
    }
  }

  Future<bool> deleteDocument(String collectionId, String documentId) async {
    if (kIsWeb) {
      throw Exception('Write operations are not allowed in web version');
    }

    try {
      await _databases.deleteDocument(
        databaseId: _databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
      return true;
    } catch (e) {
      print('Error deleting document: $e');
      return false;
    }
  }

  Future<List<Document>> queryCollection(
    String collectionId, {
    List<List<dynamic>> whereConditions = const [],
    String? orderBy,
    bool descending = false,
    int? limit,
  }) async {
    try {
      List<String> queries = [];

      for (var condition in whereConditions) {
        if (condition.length == 2) {
          queries.add(Query.equal(condition[0], condition[1]));
        }
      }

      if (orderBy != null) {
        queries.add(
            descending ? Query.orderDesc(orderBy) : Query.orderAsc(orderBy));
      }

      if (limit != null) {
        queries.add(Query.limit(limit));
      }

      final response = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: collectionId,
        queries: queries,
      );

      return response.documents;
    } catch (e) {
      print('Error querying collection: $e');
      return [];
    }
  }
}
