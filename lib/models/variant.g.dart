// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VariantImpl _$$VariantImplFromJson(Map<String, dynamic> json) =>
    _$VariantImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      price: (json['price'] as num).toDouble(),
      stockQuantity: (json['stockQuantity'] as num).toInt(),
      attributes: Map<String, String>.from(json['attributes'] as Map),
      isAvailable: json['isAvailable'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$VariantImplToJson(_$VariantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'sku': instance.sku,
      'price': instance.price,
      'stockQuantity': instance.stockQuantity,
      'attributes': instance.attributes,
      'isAvailable': instance.isAvailable,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
