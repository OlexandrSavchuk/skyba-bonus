// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReceiptProduct _$ReceiptProductFromJson(Map<String, dynamic> json) {
  return _ReceiptProduct.fromJson(json);
}

/// @nodoc
mixin _$ReceiptProduct {
  double get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get sum => throw _privateConstructorUsedError;
  double get discountSum => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get measurement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceiptProductCopyWith<ReceiptProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptProductCopyWith<$Res> {
  factory $ReceiptProductCopyWith(
          ReceiptProduct value, $Res Function(ReceiptProduct) then) =
      _$ReceiptProductCopyWithImpl<$Res, ReceiptProduct>;
  @useResult
  $Res call(
      {double quantity,
      double price,
      double sum,
      double discountSum,
      String name,
      String? measurement});
}

/// @nodoc
class _$ReceiptProductCopyWithImpl<$Res, $Val extends ReceiptProduct>
    implements $ReceiptProductCopyWith<$Res> {
  _$ReceiptProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? price = null,
    Object? sum = null,
    Object? discountSum = null,
    Object? name = null,
    Object? measurement = freezed,
  }) {
    return _then(_value.copyWith(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      sum: null == sum
          ? _value.sum
          : sum // ignore: cast_nullable_to_non_nullable
              as double,
      discountSum: null == discountSum
          ? _value.discountSum
          : discountSum // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      measurement: freezed == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptProductImplCopyWith<$Res>
    implements $ReceiptProductCopyWith<$Res> {
  factory _$$ReceiptProductImplCopyWith(_$ReceiptProductImpl value,
          $Res Function(_$ReceiptProductImpl) then) =
      __$$ReceiptProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double quantity,
      double price,
      double sum,
      double discountSum,
      String name,
      String? measurement});
}

/// @nodoc
class __$$ReceiptProductImplCopyWithImpl<$Res>
    extends _$ReceiptProductCopyWithImpl<$Res, _$ReceiptProductImpl>
    implements _$$ReceiptProductImplCopyWith<$Res> {
  __$$ReceiptProductImplCopyWithImpl(
      _$ReceiptProductImpl _value, $Res Function(_$ReceiptProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? price = null,
    Object? sum = null,
    Object? discountSum = null,
    Object? name = null,
    Object? measurement = freezed,
  }) {
    return _then(_$ReceiptProductImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      sum: null == sum
          ? _value.sum
          : sum // ignore: cast_nullable_to_non_nullable
              as double,
      discountSum: null == discountSum
          ? _value.discountSum
          : discountSum // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      measurement: freezed == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptProductImpl implements _ReceiptProduct {
  const _$ReceiptProductImpl(
      {required this.quantity,
      required this.price,
      required this.sum,
      this.discountSum = 0,
      required this.name,
      this.measurement});

  factory _$ReceiptProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptProductImplFromJson(json);

  @override
  final double quantity;
  @override
  final double price;
  @override
  final double sum;
  @override
  @JsonKey()
  final double discountSum;
  @override
  final String name;
  @override
  final String? measurement;

  @override
  String toString() {
    return 'ReceiptProduct(quantity: $quantity, price: $price, sum: $sum, discountSum: $discountSum, name: $name, measurement: $measurement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptProductImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.sum, sum) || other.sum == sum) &&
            (identical(other.discountSum, discountSum) ||
                other.discountSum == discountSum) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.measurement, measurement) ||
                other.measurement == measurement));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, quantity, price, sum, discountSum, name, measurement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptProductImplCopyWith<_$ReceiptProductImpl> get copyWith =>
      __$$ReceiptProductImplCopyWithImpl<_$ReceiptProductImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptProductImplToJson(
      this,
    );
  }
}

abstract class _ReceiptProduct implements ReceiptProduct {
  const factory _ReceiptProduct(
      {required final double quantity,
      required final double price,
      required final double sum,
      final double discountSum,
      required final String name,
      final String? measurement}) = _$ReceiptProductImpl;

  factory _ReceiptProduct.fromJson(Map<String, dynamic> json) =
      _$ReceiptProductImpl.fromJson;

  @override
  double get quantity;
  @override
  double get price;
  @override
  double get sum;
  @override
  double get discountSum;
  @override
  String get name;
  @override
  String? get measurement;
  @override
  @JsonKey(ignore: true)
  _$$ReceiptProductImplCopyWith<_$ReceiptProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
