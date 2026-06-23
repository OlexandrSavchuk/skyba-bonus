import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/formatters.dart';
import 'package:skyba_bonus/core/widgets/empty_state.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/core/widgets/skyba_slider_body.dart';
import 'package:skyba_bonus/features/promotions/providers/promotions_provider.dart';

class PromotionsScreen extends ConsumerWidget {
  const PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promotionsAsync = ref.watch(promotionsProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Акції'),
        automaticallyImplyLeading: false,
      ),
      body: SkybaSliderBody(child: promotionsAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.read(promotionsProvider.notifier).refresh(),
        ),
        data: (promotions) {
          if (promotions.isEmpty) {
            return const EmptyState(
              icon: Icons.local_offer,
              title: 'Немає активних акцій',
              subtitle: 'Слідкуйте за нашими оновленнями',
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(promotionsProvider.notifier).refresh(),
            color: AppColors.primary,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: promotions.length,
              itemBuilder: (context, index) {
                final promo = promotions[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () => context.push('/promotions/${promo.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        if (promo.imageUrl != null)
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CachedNetworkImage(
                              imageUrl: promo.imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.surfaceVariant,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.surfaceVariant,
                                child: const Center(
                                  child: Icon(
                                    Icons.local_offer,
                                    size: 40,
                                    color: AppColors.textHint,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // Content
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                promo.title,
                                style: AppTypography.titleMedium,
                              ),
                              if (promo.description != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  promo.description!,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              if (promo.endDate != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'До ${Formatters.date(promo.endDate!)}',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      )),
    );
  }
}
