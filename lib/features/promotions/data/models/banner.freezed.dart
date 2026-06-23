// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PromoBanner _$PromoBannerFromJson(Map<String, dynamic> json) {
  return _PromoBanner.fromJson(json);
}

/// @nodoc
mixin _$PromoBanner {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get linkUrl => throw _privateConstructorUsedError;
  String? get linkType => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromoBannerCopyWith<PromoBanner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromoBannerCopyWith<$Res> {
  factory $PromoBannerCopyWith(
          PromoBanner value, $Res Function(PromoBanner) then) =
      _$PromoBannerCopyWithImpl<$Res, PromoBanner>;
  @useResult
  $Res call(
      {String id,
      String? title,
      String? imageUrl,
      String? linkUrl,
      String? linkType,
      int sortOrder});
}

/// @nodoc
class _$PromoBannerCopyWithImpl<$Res, $Val extends PromoBanner>
    implements $PromoBannerCopyWith<$Res> {
  _$PromoBannerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? imageUrl = freezed,
    Object? linkUrl = freezed,
    Object? linkType = freezed,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      linkUrl: freezed == linkUrl
          ? _value.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      linkType: freezed == linkType
          ? _value.linkType
          : linkType // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromoBannerImplCopyWith<$Res>
    implements $PromoBannerCopyWith<$Res> {
  factory _$$PromoBannerImplCopyWith(
          _$PromoBannerImpl value, $Res Function(_$PromoBannerImpl) then) =
      __$$PromoBannerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      String? imageUrl,
      String? linkUrl,
      String? linkType,
      int sortOrder});
}

/// @nodoc
class __$$PromoBannerImplCopyWithImpl<$Res>
    extends _$PromoBannerCopyWithImpl<$Res, _$PromoBannerImpl>
    implements _$$PromoBannerImplCopyWith<$Res> {
  __$$PromoBannerImplCopyWithImpl(
      _$PromoBannerImpl _value, $Res Function(_$PromoBannerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? imageUrl = freezed,
    Object? linkUrl = freezed,
    Object? linkType = freezed,
    Object? sortOrder = null,
  }) {
    return _then(_$PromoBannerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      linkUrl: freezed == linkUrl
          ? _value.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      linkType: freezed == linkType
          ? _value.linkType
          : linkType // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromoBannerImpl implements _PromoBanner {
  const _$PromoBannerImpl(
      {required this.id,
      this.title,
      this.imageUrl,
      this.linkUrl,
      this.linkType,
      this.sortOrder = 0});

  factory _$PromoBannerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromoBannerImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  @override
  final String? imageUrl;
  @override
  final String? linkUrl;
  @override
  final String? linkType;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'PromoBanner(id: $id, title: $title, imageUrl: $imageUrl, linkUrl: $linkUrl, linkType: $linkType, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromoBannerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.linkUrl, linkUrl) || other.linkUrl == linkUrl) &&
            (identical(other.linkType, linkType) ||
                other.linkType == linkType) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, imageUrl, linkUrl, linkType, sortOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromoBannerImplCopyWith<_$PromoBannerImpl> get copyWith =>
      __$$PromoBannerImplCopyWithImpl<_$PromoBannerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromoBannerImplToJson(
      this,
    );
  }
}

abstract class _PromoBanner implements PromoBanner {
  const factory _PromoBanner(
      {required final String id,
      final String? title,
      final String? imageUrl,
      final String? linkUrl,
      final String? linkType,
      final int sortOrder}) = _$PromoBannerImpl;

  factory _PromoBanner.fromJson(Map<String, dynamic> json) =
      _$PromoBannerImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  String? get imageUrl;
  @override
  String? get linkUrl;
  @override
  String? get linkType;
  @override
  int get sortOrder;
  @override
  @JsonKey(ignore: true)
  _$$PromoBannerImplCopyWith<_$PromoBannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
