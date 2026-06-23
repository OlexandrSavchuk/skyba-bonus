import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/validators.dart';
import 'package:skyba_bonus/core/widgets/loading_indicator.dart';
import 'package:skyba_bonus/features/auth/providers/auth_provider.dart';
import 'package:skyba_bonus/features/profile/providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthdayController = TextEditingController();
  bool _isLoading = false;
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void _initFields() {
    if (_initialized) return;
    final profile = ref.read(profileProvider).valueOrNull;
    if (profile != null) {
      final name = [profile.name, profile.lastName]
          .where((s) => s != null && s.isNotEmpty)
          .join(' ');
      _nameController.text = name;
      _emailController.text = profile.email ?? '';
      _phoneController.text = profile.mobilePhone ?? '';
      _passwordController.text = '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022';
      if (profile.birthDay != null) {
        try {
          final d = DateTime.parse(profile.birthDay!);
          _birthdayController.text =
              '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
        } catch (_) {
          _birthdayController.text = profile.birthDay!;
        }
      }
      _initialized = true;
    }
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    try {
      final nameParts = _nameController.text.trim().split(' ');
      await ref.read(profileProvider.notifier).updateProfile({
        'name': nameParts.isNotEmpty ? nameParts.first : '',
        'lastName': nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
        'email': _emailController.text.trim(),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Профіль оновлено'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Мій профіль', style: AppTypography.titleMedium),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textSecondary, size: 22),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: AppColors.darkSurface,
                  title: Text('Вихід', style: AppTypography.titleMedium),
                  content: Text(
                    'Ви впевнені, що хочете вийти?',
                    style: AppTypography.bodyMedium,
                  ),
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
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => Center(
          child: Text(e.toString(), style: AppTypography.bodyMedium),
        ),
        data: (profile) {
          _initFields();
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _ProfileField(
                          label: "Ім'я",
                          controller: _nameController,
                          enabled: !_isLoading,
                        ),
                        const SizedBox(height: 16),
                        _ProfileField(
                          label: 'Електронна адреса',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                          enabled: !_isLoading,
                        ),
                        const SizedBox(height: 16),
                        _ProfileField(
                          label: 'Номер телефону',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          enabled: false, // phone is read-only
                        ),
                        const SizedBox(height: 16),
                        _ProfileField(
                          label: 'Пароль',
                          controller: _passwordController,
                          enabled: false,
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        _ProfileField(
                          label: 'Дата народження',
                          controller: _birthdayController,
                          enabled: false,
                        ),

                        const SizedBox(height: 40),

                        // Bread illustration at bottom
                        SizedBox(
                          height: 120,
                          child: CustomPaint(painter: _WheatDecorationPainter()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Save button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _onSave,
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Зберегти зміни'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool obscureText;

  const _ProfileField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.enabled = true,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          enabled: enabled,
          obscureText: obscureText,
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.darkSurface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderDark),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.cream, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderDark),
            ),
          ),
        ),
      ],
    );
  }
}

class _WheatDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.borderDark.withAlpha(120)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    final fill = Paint()..color = AppColors.borderDark.withAlpha(120);

    final w = size.width;
    final h = size.height;

    // Draw several wheat stalks across the bottom
    for (var i = 0; i < 7; i++) {
      final x = w * 0.08 + i * w * 0.14;
      canvas.drawLine(Offset(x, h), Offset(x, h * 0.15), p);
      for (var j = 0; j < 4; j++) {
        final y = h * 0.15 + j * h * 0.2;
        canvas.drawOval(
          Rect.fromCenter(center: Offset(x - 5, y + 4), width: 8, height: 5),
          fill,
        );
        canvas.drawOval(
          Rect.fromCenter(center: Offset(x + 5, y + 4), width: 8, height: 5),
          fill,
        );
      }
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x, h * 0.1), width: 5, height: 10),
        fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
