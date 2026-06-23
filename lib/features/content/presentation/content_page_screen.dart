import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/widgets/skyba_slider_body.dart';
import 'package:skyba_bonus/features/content/providers/content_provider.dart';

class ContentPageScreen extends ConsumerWidget {
  final String slug;
  final String title;

  const ContentPageScreen({
    super.key,
    required this.slug,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageAsync = ref.watch(contentPageProvider(slug));

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        elevation: 0,
        title: Text(title, style: AppTypography.titleMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.cream, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SkybaSliderBody(
        child: pageAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.cream),
          ),
          error: (_, __) => _FallbackContent(slug: slug),
          data: (page) => _PageContent(page: page),
        ),
      ),
    );
  }
}

// ── Page content ──────────────────────────────────────────────────────────────
class _PageContent extends StatelessWidget {
  final dynamic page;
  const _PageContent({required this.page});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        // Hero image
        if (page.imageUrl != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: page.imageUrl!,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                height: 200,
                color: AppColors.darkSurface,
              ),
              errorWidget: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 20),
        ],

        // Title
        Text(
          page.title,
          style: AppTypography.headlineSmall.copyWith(
            color: AppColors.cream,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),

        // Main content text
        if (page.content != null && (page.content as String).isNotEmpty)
          Text(
            page.content!,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),

        // Sections
        if (page.sections != null && (page.sections as List).isNotEmpty) ...[
          const SizedBox(height: 24),
          ...List.generate((page.sections as List).length, (i) {
            final section = page.sections![i];
            return _SectionCard(section: section);
          }),
        ],
      ],
    );
  }
}

// ── Section card ──────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final dynamic section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: section.imageUrl!,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (section.title != null && (section.title as String).isNotEmpty) ...[
            Text(
              section.title!,
              style: AppTypography.titleSmall.copyWith(
                color: AppColors.cream,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (section.body != null && (section.body as String).isNotEmpty)
            Text(
              section.body!,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
        ],
      ),
    );
  }
}

// ── Fallback (поки не налаштовано API) ────────────────────────────────────────
class _FallbackContent extends StatelessWidget {
  final String slug;
  const _FallbackContent({required this.slug});

  @override
  Widget build(BuildContext context) {
    final isAbout = slug == 'about-skyba';
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderDark),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isAbout ? Icons.bakery_dining : Icons.card_giftcard,
                size: 48,
                color: AppColors.cream,
              ),
              const SizedBox(height: 16),
              Text(
                isAbout ? 'Про Скибу' : 'Як використати Скибарики',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.cream,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isAbout
                    ? 'Вміст цієї сторінки налаштовується через адміністративну панель.'
                    : 'Інструкція по використанню бонусних балів налаштовується через адміністративну панель.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
