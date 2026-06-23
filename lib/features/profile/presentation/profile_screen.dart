import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/formatters.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/core/widgets/skyba_slider_body.dart';
import 'package:skyba_bonus/features/auth/providers/auth_provider.dart';
import 'package:skyba_bonus/features/profile/presentation/widgets/bonus_card_widget.dart';
import 'package:skyba_bonus/features/profile/providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Профіль'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.read(profileProvider.notifier).refresh(),
        ),
        data: (profile) {
          if (profile == null) {
            return ErrorView(
              message: 'Не вдалося завантажити профіль',
              onRetry: () => ref.read(profileProvider.notifier).refresh(),
            );
          }

          final totalBonus = profile.loyalty.fold<double>(
            0,
            (sum, l) => sum + l.bonus,
          );

          return SkybaSliderBody(
            child: RefreshIndicator(
            onRefresh: () => ref.read(profileProvider.notifier).refresh(),
            color: AppColors.primary,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Bonus Card
                BonusCardWidget(
                  totalBonus: totalBonus,
                  barcode: profile.barcode ?? '',
                ),
                const SizedBox(height: 24),

                // Personal Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Особисті дані',
                              style: AppTypography.titleMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => context.push('/profile/edit'),
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          Icons.person_outline,
                          '${profile.lastName ?? ''} ${profile.name ?? ''} ${profile.middleName ?? ''}'
                              .trim(),
                        ),
                        if (profile.mobilePhone != null)
                          _buildInfoRow(
                            Icons.phone_outlined,
                            Formatters.phone(profile.mobilePhone!),
                          ),
                        if (profile.email != null)
                          _buildInfoRow(
                            Icons.email_outlined,
                            profile.email!,
                          ),
                        if (profile.barcode != null)
                          _buildInfoRow(
                            Icons.qr_code,
                            profile.barcode!,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Logout
                OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Вихід'),
                        content:
                            const Text('Ви впевнені, що хочете вийти з акаунту?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Скасувати'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ref.read(authProvider.notifier).logout();
                            },
                            child: Text(
                              'Вийти',
                              style: TextStyle(color: AppColors.error),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout, color: AppColors.error),
                  label: Text(
                    'Вийти з акаунту',
                    style: TextStyle(color: AppColors.error),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ));
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
