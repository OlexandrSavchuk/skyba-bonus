// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loyalty_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoyaltyInfo _$LoyaltyInfoFromJson(Map<String, dynamic> json) {
  return _LoyaltyInfo.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyInfo {
  String get id => throw _privateConstructorUsedError;
  ShopBrief get shop => throw _privateConstructorUsedError;
  double get bonus => throw _privateConstructorUsedError;
  double get personalDiscount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoyaltyInfoCopyWith<LoyaltyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyInfoCopyWith<$Res> {
  factory $LoyaltyInfoCopyWith(
          LoyaltyInfo value, $Res Function(LoyaltyInfo) then) =
      _$LoyaltyInfoCopyWithImpl<$Res, LoyaltyInfo>;
  @useResult
  $Res call({String id, ShopBrief shop, double bonus, double personalDiscount});

  $ShopBriefCopyWith<$Res> get shop;
}

/// @nodoc
class _$LoyaltyInfoCopyWithImpl<$Res, $Val extends LoyaltyInfo>
    implements $LoyaltyInfoCopyWith<$Res> {
  _$LoyaltyInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shop = null,
    Object? bonus = null,
    Object? personalDiscount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shop: null == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as ShopBrief,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double,
      personalDiscount: null == personalDiscount
          ? _value.personalDiscount
          : personalDiscount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ShopBriefCopyWith<$Res> get shop {
    return $ShopBriefCopyWith<$Res>(_value.shop, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoyaltyInfoImplCopyWith<$Res>
    implements $LoyaltyInfoCopyWith<$Res> {
  factory _$$LoyaltyInfoImplCopyWith(
          _$LoyaltyInfoImpl value, $Res Function(_$LoyaltyInfoImpl) then) =
      __$$LoyaltyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, ShopBrief shop, double bonus, double personalDiscount});

  @override
  $ShopBriefCopyWith<$Res> get shop;
}

/// @nodoc
class __$$LoyaltyInfoImplCopyWithImpl<$Res>
    extends _$LoyaltyInfoCopyWithImpl<$Res, _$LoyaltyInfoImpl>
    implements _$$LoyaltyInfoImplCopyWith<$Res> {
  __$$LoyaltyInfoImplCopyWithImpl(
      _$LoyaltyInfoImpl _value, $Res Function(_$LoyaltyInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shop = null,
    Object? bonus = null,
    Object? personalDiscount = null,
  }) {
    return _then(_$LoyaltyInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shop: null == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as ShopBrief,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double,
      personalDiscount: null == personalDiscount
          ? _value.personalDiscount
          : personalDiscount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoyaltyInfoImpl implements _LoyaltyInfo {
  const _$LoyaltyInfoImpl(
      {required this.id,
      required this.shop,
      this.bonus = 0,
      this.personalDiscount = 0});

  factory _$LoyaltyInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyInfoImplFromJson(json);

  @override
  final String id;
  @override
  final ShopBrief shop;
  @override
  @JsonKey()
  final double bonus;
  @override
  @JsonKey()
  final double personalDiscount;

  @override
  String toString() {
    return 'LoyaltyInfo(id: $id, shop: $shop, bonus: $bonus, personalDiscount: $personalDiscount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shop, shop) || other.shop == shop) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.personalDiscount, personalDiscount) ||
                other.personalDiscount == personalDiscount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, shop, bonus, personalDiscount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyInfoImplCopyWith<_$LoyaltyInfoImpl> get copyWith =>
      __$$LoyaltyInfoImplCopyWithImpl<_$LoyaltyInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyInfoImplToJson(
      this,
    );
  }
}

abstract class _LoyaltyInfo implements LoyaltyInfo {
  const factory _LoyaltyInfo(
      {required final String id,
      required final ShopBrief shop,
      final double bonus,
      final double personalDiscount}) = _$LoyaltyInfoImpl;

  factory _LoyaltyInfo.fromJson(Map<String, dynamic> json) =
      _$LoyaltyInfoImpl.fromJson;

  @override
  String get id;
  @override
  ShopBrief get shop;
  @override
  double get bonus;
  @override
  double get personalDiscount;
  @override
  @JsonKey(ignore: true)
  _$$LoyaltyInfoImplCopyWith<_$LoyaltyInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShopBrief _$ShopBriefFromJson(Map<String, dynamic> json) {
  return _ShopBrief.fromJson(json);
}

/// @nodoc
mixin _$ShopBrief {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShopBriefCopyWith<ShopBrief> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopBriefCopyWith<$Res> {
  factory $ShopBriefCopyWith(ShopBrief value, $Res Function(ShopBrief) then) =
      _$ShopBriefCopyWithImpl<$Res, ShopBrief>;
  @useResult
  $Res call({String id, String name, String? address});
}

/// @nodoc
class _$ShopBriefCopyWithImpl<$Res, $Val extends ShopBrief>
    implements $ShopBriefCopyWith<$Res> {
  _$ShopBriefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
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
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShopBriefImplCopyWith<$Res>
    implements $ShopBriefCopyWith<$Res> {
  factory _$$ShopBriefImplCopyWith(
          _$ShopBriefImpl value, $Res Function(_$ShopBriefImpl) then) =
      __$$ShopBriefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? address});
}

/// @nodoc
class __$$ShopBriefImplCopyWithImpl<$Res>
    extends _$ShopBriefCopyWithImpl<$Res, _$ShopBriefImpl>
    implements _$$ShopBriefImplCopyWith<$Res> {
  __$$ShopBriefImplCopyWithImpl(
      _$ShopBriefImpl _value, $Res Function(_$ShopBriefImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
  }) {
    return _then(_$ShopBriefImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopBriefImpl implements _ShopBrief {
  const _$ShopBriefImpl({required this.id, required this.name, this.address});

  factory _$ShopBriefImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopBriefImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? address;

  @override
  String toString() {
    return 'ShopBrief(id: $id, name: $name, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopBriefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopBriefImplCopyWith<_$ShopBriefImpl> get copyWith =>
      __$$ShopBriefImplCopyWithImpl<_$ShopBriefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopBriefImplToJson(
      this,
    );
  }
}

abstract class _ShopBrief implements ShopBrief {
  const factory _ShopBrief(
      {required final String id,
      required final String name,
      final String? address}) = _$ShopBriefImpl;

  factory _ShopBrief.fromJson(Map<String, dynamic> json) =
      _$ShopBriefImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get address;
  @override
  @JsonKey(ignore: true)
  _$$ShopBriefImplCopyWith<_$ShopBriefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
