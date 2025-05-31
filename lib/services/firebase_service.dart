import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/variant.dart';
import '../config/appwrite_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class AppwriteService {
  late final Databases _databases;
  late final String _databaseId;

  AppwriteService() {
    final client = AppwriteConfig.getClient();
    _databases = Databases(client);
    _databaseId = AppwriteConfig.databaseId;
  }

  // Categories
  Future<List<Category>> getCategories() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.categoriesCollection,
      );
      return response.documents
          .map((doc) => Category.fromDocument(doc.data, doc.$id))
          .toList();
    } catch (e) {
      print('Error getting categories: $e');
      return [];
    }
  }

  Future<Category?> getCategory(String categoryId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.categoriesCollection,
        documentId: categoryId,
      );
      return Category.fromDocument(doc.data, doc.$id);
    } catch (e) {
      print('Error getting category: $e');
      return null;
    }
  }

  Future<Document?> createCategory(Category category) async {
    try {
      return await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.categoriesCollection,
        documentId: ID.unique(),
        data: category.toDocument(),
      );
    } catch (e) {
      print('Error creating category: $e');
      return null;
    }
  }

  Future<Document?> updateCategory(Category category) async {
    try {
      return await _databases.updateDocument(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.categoriesCollection,
        documentId: category.id,
        data: category.toDocument(),
      );
    } catch (e) {
      print('Error updating category: $e');
      return null;
    }
  }

  // Products
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.productsCollection,
        queries: [
          Query.equal('category_id', categoryId),
        ],
      );
      return response.documents
          .map((doc) => Product.fromDocument(doc.data, doc.$id))
          .toList();
    } catch (e) {
      print('Error getting products by category: $e');
      return [];
    }
  }

  Future<Product?> getProduct(String productId) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.productsCollection,
        documentId: productId,
      );
      return Product.fromDocument(doc.data, doc.$id);
    } catch (e) {
      print('Error getting product: $e');
      return null;
    }
  }

  Future<Document?> createProduct(Product product) async {
    try {
      return await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.productsCollection,
        documentId: ID.unique(),
        data: product.toDocument(),
      );
    } catch (e) {
      print('Error creating product: $e');
      return null;
    }
  }

  Future<Document?> updateProduct(Product product) async {
    try {
      return await _databases.updateDocument(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.productsCollection,
        documentId: product.id,
        data: product.toDocument(),
      );
    } catch (e) {
      print('Error updating product: $e');
      return null;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      await _databases.deleteDocument(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.productsCollection,
        documentId: productId,
      );
      return true;
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }

  Future<bool> deleteCategory(String categoryId) async {
    try {
      await _databases.deleteDocument(
        databaseId: _databaseId,
        collectionId: AppwriteConfig.categoriesCollection,
        documentId: categoryId,
      );
      return true;
    } catch (e) {
      print('Error deleting category: $e');
      return false;
    }
  }

  // Variants
  Future<List<Variant>> getVariants(String categoryId, String productId) async {
    final snapshot = await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: AppwriteConfig.variantsCollection,
      queries: [
        Query.equal('category_id', categoryId),
        Query.equal('product_id', productId),
      ],
    );
    return snapshot.documents
        .map((doc) => Variant.fromDocument(doc.data, doc.$id))
        .toList();
  }

  Future<Variant?> getVariant(
      String categoryId, String productId, String variantId) async {
    final doc = await _databases.getDocument(
      databaseId: _databaseId,
      collectionId: AppwriteConfig.variantsCollection,
      documentId: variantId,
    );
    return Variant.fromDocument(doc.data, doc.$id);
  }

  Future<Document?> createVariant(
      String categoryId, String productId, Variant variant) async {
    return await _databases.createDocument(
      databaseId: _databaseId,
      collectionId: AppwriteConfig.variantsCollection,
      documentId: ID.unique(),
      data: variant.toDocument(),
    );
  }

  Future<Document?> updateVariant(
      String categoryId, String productId, Variant variant) async {
    return await _databases.updateDocument(
      databaseId: _databaseId,
      collectionId: AppwriteConfig.variantsCollection,
      documentId: variant.id,
      data: variant.toDocument(),
    );
  }
}

class FirebaseService {
  final firestore.FirebaseFirestore _firestore =
      firestore.FirebaseFirestore.instance;

  // Upload categories to Firebase
  Future<void> uploadCategories(List<Map<String, dynamic>> categories) async {
    final batch = _firestore.batch();

    for (final category in categories) {
      final docRef = _firestore.collection('categories').doc(category['id']);
      batch.set(docRef, category);
    }

    await batch.commit();
  }

  // Upload products to Firebase
  Future<void> uploadProducts(List<Map<String, dynamic>> products) async {
    final batch = _firestore.batch();

    for (final product in products) {
      final docRef = _firestore.collection('products').doc(product['id']);
      batch.set(docRef, product);
    }

    await batch.commit();
  }

  // Check if data already exists
  Future<bool> isDataAlreadyUploaded() async {
    final categoriesSnapshot =
        await _firestore.collection('categories').limit(1).get();
    final productsSnapshot =
        await _firestore.collection('products').limit(1).get();

    return categoriesSnapshot.docs.isNotEmpty ||
        productsSnapshot.docs.isNotEmpty;
  }
}
