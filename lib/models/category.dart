import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  const Category._();

  const factory Category({
    required String id,
    required String name,
    required String type,
    required String description,
    required String imageUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isActive,
    required int displayOrder,
    required List<String> searchKeywords,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  factory Category.fromDocument(Map<String, dynamic> data, String id) {
    return Category(
      id: id,
      name: data['name'] as String? ?? '',
      type: data['type'] as String? ?? '',
      description: data['description'] as String? ?? '',
      imageUrl: data['image_url'] as String? ?? '',
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
      isActive: data['is_active'] as bool? ?? true,
      displayOrder: data['display_order'] as int? ?? 0,
      searchKeywords: List<String>.from(data['search_keywords'] ?? []),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
      'display_order': displayOrder,
      'search_keywords': searchKeywords,
    };
  }
}
