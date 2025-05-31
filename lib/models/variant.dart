import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'variant.freezed.dart';
part 'variant.g.dart';

mixin FirestoreSerializable {
  Map<String, dynamic> toFirestore();
}

@freezed
class Variant with _$Variant, FirestoreSerializable {
  const Variant._();

  const factory Variant({
    required String id,
    required String productId,
    required String categoryId,
    required String name,
    required String sku,
    required double price,
    required int stockQuantity,
    required Map<String, String> attributes,
    required bool isAvailable,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Variant;

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);

  factory Variant.fromDocument(Map<String, dynamic> data, String id) {
    return Variant(
      id: id,
      productId: data['product_id'] as String? ?? '',
      categoryId: data['category_id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      sku: data['sku'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      stockQuantity: data['stock_quantity'] as int? ?? 0,
      attributes: Map<String, String>.from(data['attributes']?.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          ) ??
          {}),
      isAvailable: data['is_available'] as bool? ?? true,
      createdAt: DateTime.parse(
          data['created_at'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          data['updated_at'] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'product_id': productId,
      'category_id': categoryId,
      'name': name,
      'sku': sku,
      'price': price,
      'stock_quantity': stockQuantity,
      'attributes': attributes,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'product_id': productId,
      'category_id': categoryId,
      'name': name,
      'sku': sku,
      'price': price,
      'stock_quantity': stockQuantity,
      'attributes': attributes,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
