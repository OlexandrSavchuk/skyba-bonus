import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/widgets/empty_state.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/features/catalog/presentation/widgets/product_card.dart';
import 'package:skyba_bonus/features/catalog/providers/catalog_provider.dart';

class ProductsScreen extends ConsumerWidget {
  final String categoryId;
  final String? subcategoryId;

  const ProductsScreen({
    super.key,
    required this.categoryId,
    this.subcategoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subcategoriesAsync = ref.watch(subcategoriesProvider(categoryId));
    final productsAsync = ref.watch(
      productsProvider(
        (categoryId: categoryId, subcategoryId: subcategoryId),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Товари'),
      ),
      body: Column(
        children: [
          // Subcategory filter chips
          subcategoriesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (subcategories) {
              if (subcategories.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: subcategories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: const Text('Всі'),
                          selected: subcategoryId == null,
                          onSelected: (_) {
                            // Navigate without subcategory filter
                          },
                        ),
                      );
                    }
                    final sub = subcategories[index - 1];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(sub.name),
                        selected: subcategoryId == sub.id,
                        onSelected: (_) {
                          // Navigate with subcategory filter
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),

          // Products grid
          Expanded(
            child: productsAsync.when(
              loading: () => const LoadingIndicator(),
              error: (error, _) => ErrorView(
                message: error.toString(),
                onRetry: () => ref.invalidate(
                  productsProvider(
                    (categoryId: categoryId, subcategoryId: subcategoryId),
                  ),
                ),
              ),
              data: (products) {
                if (products.isEmpty) {
                  return const EmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'Товари не знайдено',
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
