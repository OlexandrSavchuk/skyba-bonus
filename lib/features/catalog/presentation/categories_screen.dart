import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/widgets/empty_state.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/features/catalog/providers/catalog_provider.dart';
import 'package:skyba_bonus/features/shops/providers/shops_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedShopId = ref.watch(selectedShopIdProvider);
    final shopsAsync = ref.watch(shopsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Каталог'),
        automaticallyImplyLeading: false,
        actions: [
          // Shop selector
          shopsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (shops) {
              if (shops.isEmpty) return const SizedBox.shrink();

              // Auto-select first shop if none selected
              if (selectedShopId == null && shops.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(selectedShopIdProvider.notifier).state =
                      shops.first.id;
                });
              }

              return PopupMenuButton<String>(
                icon: const Icon(Icons.store),
                onSelected: (shopId) {
                  ref.read(selectedShopIdProvider.notifier).state = shopId;
                },
                itemBuilder: (context) => shops
                    .map(
                      (shop) => PopupMenuItem(
                        value: shop.id,
                        child: Text(
                          shop.name,
                          style: TextStyle(
                            fontWeight: shop.id == selectedShopId
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
      body: selectedShopId == null
          ? const EmptyState(
              icon: Icons.store,
              title: 'Оберіть магазин',
              subtitle: 'Для перегляду каталогу оберіть магазин зі списку',
            )
          : categoriesAsync.when(
              loading: () => const LoadingIndicator(),
              error: (error, _) => ErrorView(
                message: error.toString(),
                onRetry: () => ref.invalidate(categoriesProvider),
              ),
              data: (categories) {
                if (categories.isEmpty) {
                  return const EmptyState(
                    icon: Icons.category,
                    title: 'Категорії не знайдено',
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return _CategoryCard(
                      name: category.name,
                      onTap: () =>
                          context.go('/catalog/${category.id}'),
                    );
                  },
                );
              },
            ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bakery_dining,
                color: AppColors.primary,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: AppTypography.labelLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
