import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/features/catalog/data/catalog_repository.dart';
import 'package:skyba_bonus/features/catalog/data/models/category.dart';
import 'package:skyba_bonus/features/catalog/data/models/product.dart';
import 'package:skyba_bonus/features/catalog/data/models/subcategory.dart';

/// Currently selected shop for catalog browsing
final selectedShopIdProvider = StateProvider<String?>((ref) => null);

/// Categories for the selected shop
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final shopId = ref.watch(selectedShopIdProvider);
  if (shopId == null) return [];

  final repository = ref.watch(catalogRepositoryProvider);
  return repository.getCategories(shopId);
});

/// Subcategories for a given category
final subcategoriesProvider =
    FutureProvider.family<List<Subcategory>, String>((ref, categoryId) async {
  final shopId = ref.watch(selectedShopIdProvider);
  if (shopId == null) return [];

  final repository = ref.watch(catalogRepositoryProvider);
  return repository.getSubcategories(shopId, categoryId: categoryId);
});

/// Products filtered by category/subcategory
final productsProvider = FutureProvider.family<List<Product>,
    ({String? categoryId, String? subcategoryId})>((ref, params) async {
  final shopId = ref.watch(selectedShopIdProvider);
  if (shopId == null) return [];

  final repository = ref.watch(catalogRepositoryProvider);
  return repository.getProducts(
    shopId,
    categoryId: params.categoryId,
    subcategoryId: params.subcategoryId,
  );
});
