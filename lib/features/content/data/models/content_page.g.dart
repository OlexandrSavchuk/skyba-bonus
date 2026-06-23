// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentPage _$ContentPageFromJson(Map<String, dynamic> json) => ContentPage(
      slug: json['slug'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => ContentSection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentPageToJson(ContentPage instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'sections': instance.sections,
    };

ContentSection _$ContentSectionFromJson(Map<String, dynamic> json) =>
    ContentSection(
      title: json['title'] as String?,
      body: json['body'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ContentSectionToJson(ContentSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
    };
