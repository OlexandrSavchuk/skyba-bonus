import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/formatters.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/features/promotions/providers/promotions_provider.dart';

class PromotionDetailScreen extends ConsumerWidget {
  final String promotionId;

  const PromotionDetailScreen({
    super.key,
    required this.promotionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promoAsync = ref.watch(promotionDetailProvider(promotionId));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: promoAsync.when(
        loading: () => const Scaffold(body: LoadingIndicator()),
        error: (error, _) => Scaffold(
          appBar: AppBar(),
          body: ErrorView(message: error.toString()),
        ),
        data: (promo) {
          return CustomScrollView(
            slivers: [
              // Image header
              SliverAppBar(
                expandedHeight: promo.imageUrl != null ? 250 : 0,
                pinned: true,
                flexibleSpace: promo.imageUrl != null
                    ? FlexibleSpaceBar(
                        background: CachedNetworkImage(
                          imageUrl: promo.imageUrl!,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => Container(
                            color: AppColors.surfaceVariant,
                          ),
                        ),
                      )
                    : null,
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promo.title,
                        style: AppTypography.headlineSmall,
                      ),
                      const SizedBox(height: 12),

                      // Dates
                      if (promo.startDate != null || promo.endDate != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _buildDateRange(
                                    promo.startDate, promo.endDate),
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (promo.description != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          promo.description!,
                          style: AppTypography.bodyLarge,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _buildDateRange(DateTime? start, DateTime? end) {
    if (start != null && end != null) {
      return '${Formatters.date(start)} - ${Formatters.date(end)}';
    }
    if (start != null) {
      return 'З ${Formatters.date(start)}';
    }
    if (end != null) {
      return 'До ${Formatters.date(end)}';
    }
    return '';
  }
}
