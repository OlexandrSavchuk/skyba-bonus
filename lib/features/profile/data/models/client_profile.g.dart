// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientProfileImpl _$$ClientProfileImplFromJson(Map<String, dynamic> json) =>
    _$ClientProfileImpl(
      id: json['id'] as String,
      mobilePhone: json['mobilePhone'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      middleName: json['middleName'] as String?,
      locked: json['locked'] as bool? ?? false,
      birthDay: json['birthDay'] as String?,
      barcode: json['barcode'] as String?,
      loyalty: (json['loyalty'] as List<dynamic>?)
              ?.map((e) => LoyaltyInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ClientProfileImplToJson(_$ClientProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mobilePhone': instance.mobilePhone,
      'email': instance.email,
      'name': instance.name,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'locked': instance.locked,
      'birthDay': instance.birthDay,
      'barcode': instance.barcode,
      'loyalty': instance.loyalty,
    };
