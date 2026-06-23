// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Receipt _$ReceiptFromJson(Map<String, dynamic> json) {
  return _Receipt.fromJson(json);
}

/// @nodoc
mixin _$Receipt {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get cashSum => throw _privateConstructorUsedError;
  double get cardSum => throw _privateConstructorUsedError;
  double get discountSum => throw _privateConstructorUsedError;
  double get bonusAddedSum => throw _privateConstructorUsedError;
  double get bonusUsedSum => throw _privateConstructorUsedError;
  double get totalSum => throw _privateConstructorUsedError;
  List<ReceiptProduct> get products => throw _privateConstructorUsedError;
  ShopBrief? get shop => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceiptCopyWith<Receipt> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptCopyWith<$Res> {
  factory $ReceiptCopyWith(Receipt value, $Res Function(Receipt) then) =
      _$ReceiptCopyWithImpl<$Res, Receipt>;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      double cashSum,
      double cardSum,
      double discountSum,
      double bonusAddedSum,
      double bonusUsedSum,
      double totalSum,
      List<ReceiptProduct> products,
      ShopBrief? shop});

  $ShopBriefCopyWith<$Res>? get shop;
}

/// @nodoc
class _$ReceiptCopyWithImpl<$Res, $Val extends Receipt>
    implements $ReceiptCopyWith<$Res> {
  _$ReceiptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? cashSum = null,
    Object? cardSum = null,
    Object? discountSum = null,
    Object? bonusAddedSum = null,
    Object? bonusUsedSum = null,
    Object? totalSum = null,
    Object? products = null,
    Object? shop = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cashSum: null == cashSum
          ? _value.cashSum
          : cashSum // ignore: cast_nullable_to_non_nullable
              as double,
      cardSum: null == cardSum
          ? _value.cardSum
          : cardSum // ignore: cast_nullable_to_non_nullable
              as double,
      discountSum: null == discountSum
          ? _value.discountSum
          : discountSum // ignore: cast_nullable_to_non_nullable
              as double,
      bonusAddedSum: null == bonusAddedSum
          ? _value.bonusAddedSum
          : bonusAddedSum // ignore: cast_nullable_to_non_nullable
              as double,
      bonusUsedSum: null == bonusUsedSum
          ? _value.bonusUsedSum
          : bonusUsedSum // ignore: cast_nullable_to_non_nullable
              as double,
      totalSum: null == totalSum
          ? _value.totalSum
          : totalSum // ignore: cast_nullable_to_non_nullable
              as double,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ReceiptProduct>,
      shop: freezed == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as ShopBrief?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ShopBriefCopyWith<$Res>? get shop {
    if (_value.shop == null) {
      return null;
    }

    return $ShopBriefCopyWith<$Res>(_value.shop!, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReceiptImplCopyWith<$Res> implements $ReceiptCopyWith<$Res> {
  factory _$$ReceiptImplCopyWith(
          _$ReceiptImpl value, $Res Function(_$ReceiptImpl) then) =
      __$$ReceiptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      double cashSum,
      double cardSum,
      double discountSum,
      double bonusAddedSum,
      double bonusUsedSum,
      double totalSum,
      List<ReceiptProduct> products,
      ShopBrief? shop});

  @override
  $ShopBriefCopyWith<$Res>? get shop;
}

/// @nodoc
class __$$ReceiptImplCopyWithImpl<$Res>
    extends _$ReceiptCopyWithImpl<$Res, _$ReceiptImpl>
    implements _$$ReceiptImplCopyWith<$Res> {
  __$$ReceiptImplCopyWithImpl(
      _$ReceiptImpl _value, $Res Function(_$ReceiptImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? cashSum = null,
    Object? cardSum = null,
    Object? discountSum = null,
    Object? bonusAddedSum = null,
    Object? bonusUsedSum = null,
    Object? totalSum = null,
    Object? products = null,
    Object? shop = freezed,
  }) {
    return _then(_$ReceiptImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cashSum: null == cashSum
          ? _value.cashSum
          : cashSum // ignore: cast_nullable_to_non_nullable
              as double,
      cardSum: null == cardSum
          ? _value.cardSum
          : cardSum // ignore: cast_nullable_to_non_nullable
              as double,
      discountSum: null == discountSum
          ? _value.discountSum
          : discountSum // ignore: cast_nullable_to_non_nullable
              as double,
      bonusAddedSum: null == bonusAddedSum
          ? _value.bonusAddedSum
          : bonusAddedSum // ignore: cast_nullable_to_non_nullable
              as double,
      bonusUsedSum: null == bonusUsedSum
          ? _value.bonusUsedSum
          : bonusUsedSum // ignore: cast_nullable_to_non_nullable
              as double,
      totalSum: null == totalSum
          ? _value.totalSum
          : totalSum // ignore: cast_nullable_to_non_nullable
              as double,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ReceiptProduct>,
      shop: freezed == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as ShopBrief?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptImpl implements _Receipt {
  const _$ReceiptImpl(
      {required this.id,
      required this.date,
      this.cashSum = 0,
      this.cardSum = 0,
      this.discountSum = 0,
      this.bonusAddedSum = 0,
      this.bonusUsedSum = 0,
      required this.totalSum,
      final List<ReceiptProduct> products = const [],
      this.shop})
      : _products = products;

  factory _$ReceiptImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final double cashSum;
  @override
  @JsonKey()
  final double cardSum;
  @override
  @JsonKey()
  final double discountSum;
  @override
  @JsonKey()
  final double bonusAddedSum;
  @override
  @JsonKey()
  final double bonusUsedSum;
  @override
  final double totalSum;
  final List<ReceiptProduct> _products;
  @override
  @JsonKey()
  List<ReceiptProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final ShopBrief? shop;

  @override
  String toString() {
    return 'Receipt(id: $id, date: $date, cashSum: $cashSum, cardSum: $cardSum, discountSum: $discountSum, bonusAddedSum: $bonusAddedSum, bonusUsedSum: $bonusUsedSum, totalSum: $totalSum, products: $products, shop: $shop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.cashSum, cashSum) || other.cashSum == cashSum) &&
            (identical(other.cardSum, cardSum) || other.cardSum == cardSum) &&
            (identical(other.discountSum, discountSum) ||
                other.discountSum == discountSum) &&
            (identical(other.bonusAddedSum, bonusAddedSum) ||
                other.bonusAddedSum == bonusAddedSum) &&
            (identical(other.bonusUsedSum, bonusUsedSum) ||
                other.bonusUsedSum == bonusUsedSum) &&
            (identical(other.totalSum, totalSum) ||
                other.totalSum == totalSum) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.shop, shop) || other.shop == shop));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      cashSum,
      cardSum,
      discountSum,
      bonusAddedSum,
      bonusUsedSum,
      totalSum,
      const DeepCollectionEquality().hash(_products),
      shop);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptImplCopyWith<_$ReceiptImpl> get copyWith =>
      __$$ReceiptImplCopyWithImpl<_$ReceiptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptImplToJson(
      this,
    );
  }
}

abstract class _Receipt implements Receipt {
  const factory _Receipt(
      {required final String id,
      required final DateTime date,
      final double cashSum,
      final double cardSum,
      final double discountSum,
      final double bonusAddedSum,
      final double bonusUsedSum,
      required final double totalSum,
      final List<ReceiptProduct> products,
      final ShopBrief? shop}) = _$ReceiptImpl;

  factory _Receipt.fromJson(Map<String, dynamic> json) = _$ReceiptImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  double get cashSum;
  @override
  double get cardSum;
  @override
  double get discountSum;
  @override
  double get bonusAddedSum;
  @override
  double get bonusUsedSum;
  @override
  double get totalSum;
  @override
  List<ReceiptProduct> get products;
  @override
  ShopBrief? get shop;
  @override
  @JsonKey(ignore: true)
  _$$ReceiptImplCopyWith<_$ReceiptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
