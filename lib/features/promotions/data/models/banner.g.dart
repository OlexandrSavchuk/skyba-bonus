// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromoBannerImpl _$$PromoBannerImplFromJson(Map<String, dynamic> json) =>
    _$PromoBannerImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      linkUrl: json['linkUrl'] as String?,
      linkType: json['linkType'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PromoBannerImplToJson(_$PromoBannerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'linkType': instance.linkType,
      'sortOrder': instance.sortOrder,
    };
