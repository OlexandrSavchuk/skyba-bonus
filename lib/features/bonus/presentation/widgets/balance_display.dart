import 'package:flutter/material.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/formatters.dart';

class BalanceDisplay extends StatelessWidget {
  final double totalBonus;

  const BalanceDisplay({
    super.key,
    required this.totalBonus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.bonusCardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Skyba Bonus',
                style: AppTypography.titleMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const Icon(
                Icons.bakery_dining,
                color: Colors.white70,
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Загальний баланс',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            Formatters.bonus(totalBonus),
            style: AppTypography.headlineLarge.copyWith(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'бонусів',
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
