// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bonus_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BonusBalance _$BonusBalanceFromJson(Map<String, dynamic> json) {
  return _BonusBalance.fromJson(json);
}

/// @nodoc
mixin _$BonusBalance {
  double get totalBonus => throw _privateConstructorUsedError;
  List<LoyaltyInfo> get loyaltyByShop => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BonusBalanceCopyWith<BonusBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusBalanceCopyWith<$Res> {
  factory $BonusBalanceCopyWith(
          BonusBalance value, $Res Function(BonusBalance) then) =
      _$BonusBalanceCopyWithImpl<$Res, BonusBalance>;
  @useResult
  $Res call({double totalBonus, List<LoyaltyInfo> loyaltyByShop});
}

/// @nodoc
class _$BonusBalanceCopyWithImpl<$Res, $Val extends BonusBalance>
    implements $BonusBalanceCopyWith<$Res> {
  _$BonusBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBonus = null,
    Object? loyaltyByShop = null,
  }) {
    return _then(_value.copyWith(
      totalBonus: null == totalBonus
          ? _value.totalBonus
          : totalBonus // ignore: cast_nullable_to_non_nullable
              as double,
      loyaltyByShop: null == loyaltyByShop
          ? _value.loyaltyByShop
          : loyaltyByShop // ignore: cast_nullable_to_non_nullable
              as List<LoyaltyInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BonusBalanceImplCopyWith<$Res>
    implements $BonusBalanceCopyWith<$Res> {
  factory _$$BonusBalanceImplCopyWith(
          _$BonusBalanceImpl value, $Res Function(_$BonusBalanceImpl) then) =
      __$$BonusBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double totalBonus, List<LoyaltyInfo> loyaltyByShop});
}

/// @nodoc
class __$$BonusBalanceImplCopyWithImpl<$Res>
    extends _$BonusBalanceCopyWithImpl<$Res, _$BonusBalanceImpl>
    implements _$$BonusBalanceImplCopyWith<$Res> {
  __$$BonusBalanceImplCopyWithImpl(
      _$BonusBalanceImpl _value, $Res Function(_$BonusBalanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBonus = null,
    Object? loyaltyByShop = null,
  }) {
    return _then(_$BonusBalanceImpl(
      totalBonus: null == totalBonus
          ? _value.totalBonus
          : totalBonus // ignore: cast_nullable_to_non_nullable
              as double,
      loyaltyByShop: null == loyaltyByShop
          ? _value._loyaltyByShop
          : loyaltyByShop // ignore: cast_nullable_to_non_nullable
              as List<LoyaltyInfo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BonusBalanceImpl implements _BonusBalance {
  const _$BonusBalanceImpl(
      {this.totalBonus = 0, final List<LoyaltyInfo> loyaltyByShop = const []})
      : _loyaltyByShop = loyaltyByShop;

  factory _$BonusBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonusBalanceImplFromJson(json);

  @override
  @JsonKey()
  final double totalBonus;
  final List<LoyaltyInfo> _loyaltyByShop;
  @override
  @JsonKey()
  List<LoyaltyInfo> get loyaltyByShop {
    if (_loyaltyByShop is EqualUnmodifiableListView) return _loyaltyByShop;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loyaltyByShop);
  }

  @override
  String toString() {
    return 'BonusBalance(totalBonus: $totalBonus, loyaltyByShop: $loyaltyByShop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonusBalanceImpl &&
            (identical(other.totalBonus, totalBonus) ||
                other.totalBonus == totalBonus) &&
            const DeepCollectionEquality()
                .equals(other._loyaltyByShop, _loyaltyByShop));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalBonus,
      const DeepCollectionEquality().hash(_loyaltyByShop));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusBalanceImplCopyWith<_$BonusBalanceImpl> get copyWith =>
      __$$BonusBalanceImplCopyWithImpl<_$BonusBalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusBalanceImplToJson(
      this,
    );
  }
}

abstract class _BonusBalance implements BonusBalance {
  const factory _BonusBalance(
      {final double totalBonus,
      final List<LoyaltyInfo> loyaltyByShop}) = _$BonusBalanceImpl;

  factory _BonusBalance.fromJson(Map<String, dynamic> json) =
      _$BonusBalanceImpl.fromJson;

  @override
  double get totalBonus;
  @override
  List<LoyaltyInfo> get loyaltyByShop;
  @override
  @JsonKey(ignore: true)
  _$$BonusBalanceImplCopyWith<_$BonusBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
