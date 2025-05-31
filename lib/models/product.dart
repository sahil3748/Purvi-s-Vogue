import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String name,
    required String description,
    required double price,
    required String categoryId,
    required List<String> images,
    required Map<String, String> specifications,
    required bool isAvailable,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<String> searchKeywords,
    @Default(0.0) double discountPercentage,
    @Default(0) int stockQuantity,
    @Default('') String gender,
    @Default([]) List<String> tags,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.fromDocument(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      categoryId: data['category_id'] as String? ?? '',
      images: List<String>.from(data['images'] ?? []),
      specifications: Map<String, String>.from(data['specifications']?.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          ) ??
          {}),
      isAvailable: data['is_available'] as bool? ?? true,
      createdAt: DateTime.parse(
          data['created_at'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          data['updated_at'] as String? ?? DateTime.now().toIso8601String()),
      searchKeywords: List<String>.from(data['search_keywords'] ?? []),
      discountPercentage:
          (data['discount_percentage'] as num?)?.toDouble() ?? 0.0,
      stockQuantity: data['stock_quantity'] as int? ?? 0,
      gender: data['gender'] as String? ?? '',
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'images': images,
      'specifications': specifications,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'search_keywords': searchKeywords,
      'discount_percentage': discountPercentage,
      'stock_quantity': stockQuantity,
      'gender': gender,
      'tags': tags,
    };
  }
}
