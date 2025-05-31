// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  Map<String, String> get specifications => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<String> get searchKeywords => throw _privateConstructorUsedError;
  double get discountPercentage => throw _privateConstructorUsedError;
  int get stockQuantity => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double price,
      String categoryId,
      List<String> images,
      Map<String, String> specifications,
      bool isAvailable,
      DateTime createdAt,
      DateTime updatedAt,
      List<String> searchKeywords,
      double discountPercentage,
      int stockQuantity,
      String gender,
      List<String> tags});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? categoryId = null,
    Object? images = null,
    Object? specifications = null,
    Object? isAvailable = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? searchKeywords = null,
    Object? discountPercentage = null,
    Object? stockQuantity = null,
    Object? gender = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      specifications: null == specifications
          ? _value.specifications
          : specifications // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      searchKeywords: null == searchKeywords
          ? _value.searchKeywords
          : searchKeywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double price,
      String categoryId,
      List<String> images,
      Map<String, String> specifications,
      bool isAvailable,
      DateTime createdAt,
      DateTime updatedAt,
      List<String> searchKeywords,
      double discountPercentage,
      int stockQuantity,
      String gender,
      List<String> tags});
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? categoryId = null,
    Object? images = null,
    Object? specifications = null,
    Object? isAvailable = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? searchKeywords = null,
    Object? discountPercentage = null,
    Object? stockQuantity = null,
    Object? gender = null,
    Object? tags = null,
  }) {
    return _then(_$ProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      specifications: null == specifications
          ? _value._specifications
          : specifications // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      searchKeywords: null == searchKeywords
          ? _value._searchKeywords
          : searchKeywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl extends _Product {
  const _$ProductImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.categoryId,
      required final List<String> images,
      required final Map<String, String> specifications,
      required this.isAvailable,
      required this.createdAt,
      required this.updatedAt,
      required final List<String> searchKeywords,
      this.discountPercentage = 0.0,
      this.stockQuantity = 0,
      this.gender = '',
      final List<String> tags = const []})
      : _images = images,
        _specifications = specifications,
        _searchKeywords = searchKeywords,
        _tags = tags,
        super._();

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final String categoryId;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final Map<String, String> _specifications;
  @override
  Map<String, String> get specifications {
    if (_specifications is EqualUnmodifiableMapView) return _specifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_specifications);
  }

  @override
  final bool isAvailable;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<String> _searchKeywords;
  @override
  List<String> get searchKeywords {
    if (_searchKeywords is EqualUnmodifiableListView) return _searchKeywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchKeywords);
  }

  @override
  @JsonKey()
  final double discountPercentage;
  @override
  @JsonKey()
  final int stockQuantity;
  @override
  @JsonKey()
  final String gender;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, categoryId: $categoryId, images: $images, specifications: $specifications, isAvailable: $isAvailable, createdAt: $createdAt, updatedAt: $updatedAt, searchKeywords: $searchKeywords, discountPercentage: $discountPercentage, stockQuantity: $stockQuantity, gender: $gender, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality()
                .equals(other._specifications, _specifications) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._searchKeywords, _searchKeywords) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      price,
      categoryId,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_specifications),
      isAvailable,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_searchKeywords),
      discountPercentage,
      stockQuantity,
      gender,
      const DeepCollectionEquality().hash(_tags));

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product extends Product {
  const factory _Product(
      {required final String id,
      required final String name,
      required final String description,
      required final double price,
      required final String categoryId,
      required final List<String> images,
      required final Map<String, String> specifications,
      required final bool isAvailable,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final List<String> searchKeywords,
      final double discountPercentage,
      final int stockQuantity,
      final String gender,
      final List<String> tags}) = _$ProductImpl;
  const _Product._() : super._();

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  String get categoryId;
  @override
  List<String> get images;
  @override
  Map<String, String> get specifications;
  @override
  bool get isAvailable;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<String> get searchKeywords;
  @override
  double get discountPercentage;
  @override
  int get stockQuantity;
  @override
  String get gender;
  @override
  List<String> get tags;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
