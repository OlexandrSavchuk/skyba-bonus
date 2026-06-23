import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/formatters.dart';
import 'package:skyba_bonus/features/bonus/providers/bonus_provider.dart';
import 'package:skyba_bonus/features/notifications/providers/notifications_provider.dart';
import 'package:skyba_bonus/features/promotions/providers/promotions_provider.dart';

class BonusHomeScreen extends ConsumerWidget {
  const BonusHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance      = ref.watch(bonusBalanceProvider);
    final barcode      = ref.watch(barcodeProvider);
    final promotionsAsync = ref.watch(promotionsProvider);
    final unreadCount  = ref.watch(unreadNotificationsCountProvider);

    return Scaffold(
      backgroundColor: AppColors.creamBg,
      appBar: AppBar(
        backgroundColor: AppColors.creamBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person_outline,
              color: AppColors.textDark, size: 26),
          onPressed: () => context.go('/profile'),
        ),
        title: Image.asset('assets/images/logo.png',
            height: 38, fit: BoxFit.contain),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: AppColors.textDark, size: 26),
                onPressed: () => context.go('/notifications'),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53935),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // ── Main scrollable content ───────────────────────────────────────
          RefreshIndicator(
            onRefresh: () => ref.read(promotionsProvider.notifier).refresh(),
            color: AppColors.primary,
            backgroundColor: AppColors.creamBg,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // ── Hero bread image ────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/main.png',
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Barcode / Bonus card ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _BonusCard(
                    totalBonus: balance.totalBonus,
                    barcode: barcode,
                  ),
                ),
                const SizedBox(height: 16),

                // ── Info buttons ────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _InfoButton(
                        icon: Icons.bakery_dining_outlined,
                        label: 'Скибоманам про Скибу',
                        onTap: () => context.push('/pages/about-skyba'),
                      ),
                      const SizedBox(height: 10),
                      _InfoButton(
                        icon: Icons.card_giftcard_outlined,
                        label: 'Як використати Скибарики',
                        onTap: () => context.push('/pages/how-to-use'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Promotions section ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Скуштуйте це',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/promotions'),
                        child: Text(
                          'Всі акції',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.textDarkSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // ── Promo cards ─────────────────────────────────────────────
                SizedBox(
                  height: 190,
                  child: promotionsAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primary),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (promos) {
                      if (promos.isEmpty) {
                        return Center(
                          child: Text(
                            'Немає активних акцій',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textDarkSecondary,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: promos.length,
                        itemBuilder: (context, index) {
                          final promo = promos[index];
                          return _PromoCard(
                            promo: promo,
                            onTap: () =>
                                context.push('/promotions/${promo.id}'),
                          );
                        },
                      );
                    },
                  ),
                ),

                // ── Bottom decorative slider_bg space ───────────────────────
                const SizedBox(height: 120),
              ],
            ),
          ),

          // ── slider_bg.png pinned at bottom ────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Image.asset(
                'assets/images/slider_bg.png',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bonus card (barcode)
// ─────────────────────────────────────────────────────────────────────────────
class _BonusCard extends StatelessWidget {
  final double totalBonus;
  final String barcode;

  const _BonusCard({required this.totalBonus, required this.barcode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: barcode.isNotEmpty ? () => context.push('/qr') : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ваші бонуси',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.textDarkSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.qr_code,
                    color: AppColors.textDarkSecondary, size: 24),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Ваші скибарики',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textDarkSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  Formatters.bonus(totalBonus),
                  style: AppTypography.headlineLarge.copyWith(
                    color: AppColors.primary,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            if (barcode.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.borderCream),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CustomPaint(
                      painter: _BarcodePainter(barcode),
                      size: const Size(double.infinity, 52),
                      child: const SizedBox(width: double.infinity),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Скануй штрих-код',
                      style: TextStyle(
                        fontFamily: 'DiariaSansPro',
                        fontSize: 12,
                        color: AppColors.textDarkSecondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BarcodePainter extends CustomPainter {
  final String data;
  _BarcodePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final barWidths = [
      2.0, 1.0, 3.0, 1.0, 2.0, 1.0, 2.0, 3.0, 1.0, 2.0,
      1.0, 3.0, 2.0, 1.0, 1.0, 2.0, 3.0, 1.0, 2.0, 1.0,
    ];
    final totalW = barWidths.fold(0.0, (a, b) => a + b);
    final scale = size.width / totalW;

    double x = 0;
    for (var i = 0; i < barWidths.length; i++) {
      if (i % 2 == 0) {
        canvas.drawRect(
          Rect.fromLTWH(x, 0, barWidths[i] * scale, size.height),
          paint,
        );
      }
      x += barWidths[i] * scale;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Promo card
// ─────────────────────────────────────────────────────────────────────────────
class _PromoCard extends StatelessWidget {
  final dynamic promo;
  final VoidCallback onTap;

  const _PromoCard({required this.promo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: promo.imageUrl != null
                  ? Image.network(
                      promo.imageUrl!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _PlaceholderImage(),
                    )
                  : _PlaceholderImage(),
            ),
            // text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promo.title,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (promo.endDate != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'До ${Formatters.date(promo.endDate!)}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textDarkSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: const Color(0xFFF0EDE0),
      child: const Center(
        child: Icon(Icons.local_offer,
            size: 36, color: AppColors.textDarkHint),
      ),
    );
  }
}

// ── Info button ───────────────────────────────────────────────────────────────
class _InfoButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _InfoButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'DiariaSansPro',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 14, color: AppColors.textDarkSecondary),
          ],
        ),
      ),
    );
  }
}
