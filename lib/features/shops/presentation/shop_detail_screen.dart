import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/core/widgets/skyba_slider_body.dart';
import 'package:skyba_bonus/features/shops/providers/shops_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailScreen extends ConsumerWidget {
  final String shopId;

  const ShopDetailScreen({
    super.key,
    required this.shopId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopAsync = ref.watch(shopDetailProvider(shopId));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Магазин'),
      ),
      body: SkybaSliderBody(child: shopAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(message: error.toString()),
        data: (shop) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Shop icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.store,
                    size: 40,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Name
              Text(
                shop.name,
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Info card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (shop.address != null)
                        _buildInfoRow(
                          Icons.location_on_outlined,
                          'Адреса',
                          shop.address!,
                        ),
                      if (shop.city != null)
                        _buildInfoRow(
                          Icons.location_city,
                          'Місто',
                          shop.city!,
                        ),
                      if (shop.workHours != null)
                        _buildInfoRow(
                          Icons.access_time,
                          'Графік роботи',
                          shop.workHours!,
                        ),
                      if (shop.fop != null)
                        _buildInfoRow(
                          Icons.business,
                          'ФОП',
                          shop.fop!,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Open in maps
              if (shop.address != null)
                ElevatedButton.icon(
                  onPressed: () async {
                    final query = Uri.encodeComponent(
                      '${shop.address ?? ''} ${shop.city ?? ''}'.trim(),
                    );
                    final uri = Uri.parse(
                      'https://www.google.com/maps/search/?api=1&query=$query',
                    );
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                  icon: const Icon(Icons.map),
                  label: const Text('Відкрити на карті'),
                ),
            ],
          );
        },
      )),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.labelSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
