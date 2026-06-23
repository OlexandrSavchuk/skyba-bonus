import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/formatters.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/features/transactions/providers/transactions_provider.dart';

class ReceiptDetailScreen extends ConsumerWidget {
  final String receiptId;

  const ReceiptDetailScreen({
    super.key,
    required this.receiptId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiptAsync = ref.watch(receiptDetailProvider(receiptId));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Деталі чеку'),
      ),
      body: receiptAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => ErrorView(message: error.toString()),
        data: (receipt) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Shop and date
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receipt.shop?.name ?? 'Skyba',
                        style: AppTypography.titleLarge,
                      ),
                      if (receipt.shop?.address != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          receipt.shop!.address!,
                          style: AppTypography.bodySmall,
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        Formatters.dateTime(receipt.date),
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Products
              Text('Товари', style: AppTypography.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    ...receipt.products.asMap().entries.map((entry) {
                      final index = entry.key;
                      final product = entry.value;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: AppTypography.bodyMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${product.quantity} ${product.measurement ?? 'шт'} x ${Formatters.currency(product.price)}',
                                        style: AppTypography.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      Formatters.currency(product.sum),
                                      style: AppTypography.labelLarge,
                                    ),
                                    if (product.discountSum > 0)
                                      Text(
                                        '-${Formatters.currency(product.discountSum)}',
                                        style:
                                            AppTypography.labelSmall.copyWith(
                                          color: AppColors.success,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (index < receipt.products.length - 1)
                            const Divider(height: 1),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Payment summary
              Text('Оплата', style: AppTypography.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildSummaryRow(
                        'Загальна сума',
                        Formatters.currency(receipt.totalSum),
                      ),
                      if (receipt.discountSum > 0)
                        _buildSummaryRow(
                          'Знижка',
                          '-${Formatters.currency(receipt.discountSum)}',
                          valueColor: AppColors.success,
                        ),
                      if (receipt.cashSum > 0)
                        _buildSummaryRow(
                          'Готівка',
                          Formatters.currency(receipt.cashSum),
                        ),
                      if (receipt.cardSum > 0)
                        _buildSummaryRow(
                          'Картка',
                          Formatters.currency(receipt.cardSum),
                        ),
                      const Divider(),
                      if (receipt.bonusAddedSum > 0)
                        _buildSummaryRow(
                          'Нараховано бонусів',
                          '+${receipt.bonusAddedSum.toStringAsFixed(0)}',
                          valueColor: AppColors.success,
                        ),
                      if (receipt.bonusUsedSum > 0)
                        _buildSummaryRow(
                          'Використано бонусів',
                          '-${receipt.bonusUsedSum.toStringAsFixed(0)}',
                          valueColor: AppColors.error,
                        ),
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

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyMedium),
          Text(
            value,
            style: AppTypography.labelLarge.copyWith(
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
