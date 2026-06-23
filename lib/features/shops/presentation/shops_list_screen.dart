import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/core/widgets/skyba_slider_body.dart';
import 'package:skyba_bonus/features/auth/data/models/company.dart';
import 'package:skyba_bonus/features/auth/providers/companies_provider.dart';
import 'package:skyba_bonus/features/shops/data/models/shop.dart';
import 'package:skyba_bonus/features/shops/providers/shops_provider.dart';

class ShopsListScreen extends ConsumerWidget {
  const ShopsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopsAsync = ref.watch(shopsProvider);
    final selectedCompanyId = ref.watch(selectedRegionProvider);
    final companiesAsync = ref.watch(companiesProvider);

    final selectedCompanyName = companiesAsync.whenOrNull(
      data: (companies) => companies
          .where((c) => c.id == selectedCompanyId)
          .map((c) => c.name)
          .firstOrNull,
    );

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Магазини',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        actions: [
          // Region selector button
          GestureDetector(
            onTap: () => _showRegionPicker(context, ref, companiesAsync),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderDark),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on,
                      size: 14, color: AppColors.cream),
                  const SizedBox(width: 4),
                  Text(
                    selectedCompanyName ?? 'Всі регіони',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.cream,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.expand_more,
                      size: 14, color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SkybaSliderBody(child: shopsAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.read(shopsProvider.notifier).refresh(),
        ),
        data: (shops) {
          if (shops.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.storefront_outlined,
                      size: 64, color: AppColors.textHint),
                  const SizedBox(height: 16),
                  Text(
                    'Магазини не знайдено',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (selectedCompanyId != null) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () =>
                          ref.read(selectedRegionProvider.notifier).select(null),
                      child: Text(
                        'Показати всі регіони',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.cream,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(shopsProvider.notifier).refresh(),
            color: AppColors.cream,
            backgroundColor: AppColors.darkSurface,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: shops.length,
              itemBuilder: (context, index) => _ShopCard(
                shop: shops[index],
                onTap: () => context.push('/shops/${shops[index].id}'),
              ),
            ),
          );
        },
      )),
    );
  }

  void _showRegionPicker(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<Company>> companiesAsync,
  ) {
    final companies = companiesAsync.valueOrNull ?? [];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderDark,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Вибір регіону',
                style: AppTypography.titleMedium,
              ),
              const SizedBox(height: 12),
              // "All regions" option
              _RegionTile(
                name: 'Всі регіони',
                isSelected: ref.read(selectedRegionProvider) == null,
                onTap: () {
                  ref.read(selectedRegionProvider.notifier).select(null);
                  Navigator.pop(ctx);
                },
              ),
              ...companies.map(
                (company) => _RegionTile(
                  name: company.region ?? company.name,
                  isSelected:
                      ref.read(selectedRegionProvider) == company.id,
                  onTap: () {
                    ref
                        .read(selectedRegionProvider.notifier)
                        .select(company.id);
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RegionTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _RegionTile({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: isSelected ? AppColors.cream : AppColors.textSecondary,
        size: 20,
      ),
      title: Text(
        name,
        style: AppTypography.bodyMedium.copyWith(
          color: isSelected ? AppColors.cream : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  final Shop shop;
  final VoidCallback onTap;

  const _ShopCard({required this.shop, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDark),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.darkSurface2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.storefront,
                color: AppColors.cream,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (shop.address != null || shop.city != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            [shop.city, shop.address]
                                .where((s) => s != null && s.isNotEmpty)
                                .join(', '),
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (shop.workHours != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          shop.workHours!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (shop.phone != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.phone_outlined,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          shop.phone!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
