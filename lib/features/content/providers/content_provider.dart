import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/features/content/data/content_repository.dart';
import 'package:skyba_bonus/features/content/data/models/content_page.dart';

final contentPageProvider =
    FutureProvider.family<ContentPage, String>((ref, slug) async {
  return ref.read(contentRepositoryProvider).getPage(slug);
});
