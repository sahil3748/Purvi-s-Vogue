import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../config/appwrite_config.dart';

class DataService {
  late final appwrite.Databases _databases;
  late final String _databaseId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DataService() {
    if (!kIsWeb) {
      final client = appwrite.Client()
          .setEndpoint(AppwriteConfig.endpoint)
          .setProject(AppwriteConfig.projectId);
      _databases = appwrite.Databases(client);
      _databaseId = AppwriteConfig.databaseId;
    }
  }

  Future<List<appwrite_models.Document>> getCollection(
      String collectionId) async {
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

  Future<appwrite_models.Document?> getDocument(
      String collectionId, String documentId) async {
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

  Future<appwrite_models.Document?> addDocument(
      String collectionId, Map<String, dynamic> data) async {
    if (kIsWeb) {
      throw Exception('Write operations are not allowed in web version');
    }

    try {
      return await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: collectionId,
        documentId: appwrite.ID.unique(),
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

  Future<appwrite_models.Document?> updateDocument(
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

  Future<List<appwrite_models.Document>> queryCollection(
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
          queries.add(appwrite.Query.equal(condition[0], condition[1]));
        }
      }

      if (orderBy != null) {
        queries.add(descending
            ? appwrite.Query.orderDesc(orderBy)
            : appwrite.Query.orderAsc(orderBy));
      }

      if (limit != null) {
        queries.add(appwrite.Query.limit(limit));
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

  // Get all products
  Stream<QuerySnapshot> getProducts() {
    return _firestore.collection('products').snapshots();
  }

  // Get products by category
  Stream<QuerySnapshot> getProductsByCategory(String category) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots();
  }

  // Get all categories
  Stream<QuerySnapshot> getCategories() {
    return _firestore.collection('categories').snapshots();
  }

  // Add a product
  Future<void> addProduct(Map<String, dynamic> product) {
    return _firestore.collection('products').add(product);
  }

  // Update a product
  Future<void> updateProduct(String id, Map<String, dynamic> product) {
    return _firestore.collection('products').doc(id).update(product);
  }

  // Delete a product
  Future<void> deleteProduct(String id) {
    return _firestore.collection('products').doc(id).delete();
  }

  // Add a category
  Future<void> addCategory(Map<String, dynamic> category) {
    return _firestore.collection('categories').add(category);
  }

  // Update a category
  Future<void> updateCategory(String id, Map<String, dynamic> category) {
    return _firestore.collection('categories').doc(id).update(category);
  }

  // Delete a category
  Future<void> deleteCategory(String id) {
    return _firestore.collection('categories').doc(id).delete();
  }
}
