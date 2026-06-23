import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/formatters.dart';
import 'package:skyba_bonus/core/widgets/error_view.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/core/widgets/skyba_slider_body.dart';
import 'package:skyba_bonus/features/transactions/providers/transactions_provider.dart';

class TransactionsListScreen extends ConsumerWidget {
  const TransactionsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);
    final dateRange = ref.watch(transactionsDateRangeProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        elevation: 0,
        automaticallyImplyLeading: false,
        title:
            Text('Твоя смачна історія', style: AppTypography.headlineSmall),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textPrimary),
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                initialDateRange: DateTimeRange(
                  start: dateRange.from,
                  end: dateRange.to,
                ),
                locale: const Locale('uk', 'UA'),
                builder: (context, child) => Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: AppColors.cream,
                      onPrimary: AppColors.primary,
                      surface: AppColors.darkSurface,
                    ),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) {
                ref.read(transactionsDateRangeProvider.notifier).state =
                    (from: picked.start, to: picked.end);
              }
            },
          ),
        ],
      ),
      body: SkybaSliderBody(child: transactionsAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) {
          final isServerError = error.toString().contains('500');
          if (isServerError) {
            return _EmptyPurchases(dateRange: dateRange);
          }
          return ErrorView(
            message: error.toString(),
            onRetry: () => ref.read(transactionsProvider.notifier).refresh(),
          );
        },
        data: (receipts) {
          // Compute totals
          double totalSpent = 0;
          double totalUsed = 0;
          double totalEarned = 0;
          for (final r in receipts) {
            totalSpent += r.totalSum;
            totalUsed += r.bonusUsedSum;
            totalEarned += r.bonusAddedSum;
          }

          if (receipts.isEmpty) {
            return _EmptyPurchases(dateRange: dateRange);
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(transactionsProvider.notifier).refresh(),
            color: AppColors.cream,
            backgroundColor: AppColors.darkSurface,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: receipts.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _DateRangeBar(dateRange: dateRange);
                }
                if (index == 1) {
                  return _SummaryCard(
                    spent: totalSpent,
                    used: totalUsed,
                    earned: totalEarned,
                  );
                }

                final receipt = receipts[index - 2];
                return _TransactionRow(
                  shopName: receipt.shop?.name ?? 'Skyba',
                  date: Formatters.date(receipt.date),
                  total: receipt.totalSum,
                  bonusUsed: receipt.bonusUsedSum,
                  bonusEarned: receipt.bonusAddedSum,
                  onTap: () =>
                      context.push('/transactions/${receipt.id}'),
                );
              },
            ),
          );
        },
      )),
    );
  }
}

class _EmptyPurchases extends StatelessWidget {
  final ({DateTime from, DateTime to}) dateRange;
  const _EmptyPurchases({required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateRangeBar(dateRange: dateRange),
        const Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🍞', style: TextStyle(fontSize: 56)),
                SizedBox(height: 20),
                Text(
                  'Тут буде ваша смачна\nісторія покупок',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DiariaSansPro',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Робіть покупки у наших магазинах\nі отримуйте Скибарики',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DiariaSansPro',
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DateRangeBar extends StatelessWidget {
  final ({DateTime from, DateTime to}) dateRange;

  const _DateRangeBar({required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Formatters.date(dateRange.from),
            style: AppTypography.bodySmall,
          ),
          Text(
            Formatters.date(dateRange.to),
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double spent;
  final double used;
  final double earned;

  const _SummaryCard({
    required this.spent,
    required this.used,
    required this.earned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryCell(
            label: 'Витрачено',
            value: Formatters.currency(spent),
            valueColor: AppColors.textDark,
          ),
          _Vdivider(),
          _SummaryCell(
            label: 'Списано',
            value: used > 0 ? '-${Formatters.currency(used)}' : '₴ 0',
            valueColor: used > 0 ? AppColors.error : AppColors.textDark,
            sub: 'балами',
          ),
          _Vdivider(),
          _SummaryCell(
            label: 'Накопичено',
            value: earned > 0 ? '+${Formatters.currency(earned)}' : '₴ 0',
            valueColor: earned > 0 ? AppColors.success : AppColors.textDark,
            sub: 'балами',
          ),
        ],
      ),
    );
  }
}

class _Vdivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const SizedBox(width: 1, height: 40,
          child: VerticalDivider(color: AppColors.borderCream, thickness: 1));
}

class _SummaryCell extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final String? sub;

  const _SummaryCell({
    required this.label,
    required this.value,
    required this.valueColor,
    this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'DiariaSansPro',
            fontSize: 11,
            color: AppColors.textDarkSecondary,
          ),
        ),
        if (sub != null)
          Text(
            sub!,
            style: const TextStyle(
              fontFamily: 'DiariaSansPro',
              fontSize: 11,
              color: AppColors.textDarkSecondary,
            ),
          ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'DiariaSansPro',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final String shopName;
  final String date;
  final double total;
  final double bonusUsed;
  final double bonusEarned;
  final VoidCallback onTap;

  const _TransactionRow({
    required this.shopName,
    required this.date,
    required this.total,
    required this.bonusUsed,
    required this.bonusEarned,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderDark, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shopName, style: AppTypography.bodyMedium),
                  const SizedBox(height: 2),
                  Text(
                    Formatters.currency(total),
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(date, style: AppTypography.bodySmall),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (bonusUsed > 0)
                      Text(
                        '-${Formatters.currency(bonusUsed)}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (bonusUsed > 0 && bonusEarned >= 0)
                      const SizedBox(width: 8),
                    Text(
                      bonusEarned > 0
                          ? '+${Formatters.currency(bonusEarned)}'
                          : '+0 ₴',
                      style: AppTypography.labelSmall.copyWith(
                        color: bonusEarned > 0
                            ? AppColors.success
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
