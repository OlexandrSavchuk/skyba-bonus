import 'package:json_annotation/json_annotation.dart';

part 'content_page.g.dart';

@JsonSerializable()
class ContentPage {
  final String slug;
  final String title;
  final String? content;
  final String? imageUrl;
  final List<ContentSection>? sections;

  const ContentPage({
    required this.slug,
    required this.title,
    this.content,
    this.imageUrl,
    this.sections,
  });

  factory ContentPage.fromJson(Map<String, dynamic> json) =>
      _$ContentPageFromJson(json);
  Map<String, dynamic> toJson() => _$ContentPageToJson(this);
}

@JsonSerializable()
class ContentSection {
  final String? title;
  final String? body;
  final String? imageUrl;

  const ContentSection({this.title, this.body, this.imageUrl});

  factory ContentSection.fromJson(Map<String, dynamic> json) =>
      _$ContentSectionFromJson(json);
  Map<String, dynamic> toJson() => _$ContentSectionToJson(this);
}
