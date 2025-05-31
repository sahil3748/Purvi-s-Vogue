// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      categoryId: json['categoryId'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      specifications: Map<String, String>.from(json['specifications'] as Map),
      isAvailable: json['isAvailable'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      searchKeywords: (json['searchKeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
      gender: json['gender'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'categoryId': instance.categoryId,
      'images': instance.images,
      'specifications': instance.specifications,
      'isAvailable': instance.isAvailable,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'searchKeywords': instance.searchKeywords,
      'discountPercentage': instance.discountPercentage,
      'stockQuantity': instance.stockQuantity,
      'gender': instance.gender,
      'tags': instance.tags,
    };
