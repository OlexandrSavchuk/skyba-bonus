import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_theme.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/validators.dart';
import 'package:skyba_bonus/features/auth/providers/auth_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        await ref.read(authProvider.notifier).resetPassword(
              _emailController.text.trim(),
            );
        setState(() {
          _isSuccess = true;
          _isLoading = false;
        });
      } catch (e) {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: AppColors.creamBg,
        body: SafeArea(
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.textDark),
                  onPressed: () => context.pop(),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _isSuccess ? _buildSuccess() : _buildForm(),
                ),
              ),

              if (!_isSuccess)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onSubmit,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.cream,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Відправити посилання'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 60),
        Icon(
          Icons.check_circle_outline,
          size: 80,
          color: AppColors.success,
        ),
        const SizedBox(height: 24),
        Text(
          'Перевірте пошту',
          style: AppTypography.headlineMediumLight,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Ми надіслали посилання для зміни пароля на вашу електронну адресу.',
          style: AppTypography.bodyLargeLight.copyWith(
            color: AppColors.textDarkSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () => context.go('/login'),
          child: const Text('Повернутися до входу'),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            'Скинути пароль',
            style: AppTypography.headlineMediumLight,
          ),
          const SizedBox(height: 8),
          Text(
            'Ми відправимо на вашу електронну адресу посилання для зміни пароля.',
            style: AppTypography.bodyMediumLight.copyWith(
              color: AppColors.textDarkSecondary,
            ),
          ),
          const SizedBox(height: 32),

          Text(
            'Електронна адреса',
            style: AppTypography.labelLargeLight,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            style: TextStyle(color: AppColors.textDark),
            decoration: const InputDecoration(
              hintText: 'Введіть свою електронну адресу',
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: Validators.validateEmail,
            enabled: !_isLoading,
            onFieldSubmitted: (_) => _onSubmit(),
          ),

          const SizedBox(height: 40),

          // Croissant illustration
          SizedBox(
            height: 200,
            child: CustomPaint(painter: _CroissantPainter()),
          ),
        ],
      ),
    );
  }
}

class _CroissantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFFD4C4A8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Croissant body
    final body = Path()
      ..moveTo(cx - 70, cy + 10)
      ..cubicTo(cx - 80, cy - 30, cx - 40, cy - 50, cx, cy - 40)
      ..cubicTo(cx + 40, cy - 50, cx + 80, cy - 30, cx + 70, cy + 10)
      ..cubicTo(cx + 50, cy + 30, cx - 50, cy + 30, cx - 70, cy + 10);
    canvas.drawPath(body, p);

    // Score lines
    canvas.drawLine(Offset(cx - 30, cy - 30), Offset(cx - 20, cy + 15), p);
    canvas.drawLine(Offset(cx, cy - 35), Offset(cx + 5, cy + 10), p);
    canvas.drawLine(Offset(cx + 30, cy - 30), Offset(cx + 25, cy + 15), p);

    // Wheat stalk
    canvas.drawLine(Offset(cx + 60, cy + 25), Offset(cx + 100, cy - 40), p);
    final fill = Paint()..color = const Color(0xFFD4C4A8);
    for (var i = 0; i < 4; i++) {
      final gy = cy - 30 + i * 14.0;
      final gx = cx + 85 - i * 8.0;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(gx - 6, gy), width: 10, height: 6),
        fill,
      );
      canvas.drawOval(
        Rect.fromCenter(center: Offset(gx + 6, gy), width: 10, height: 6),
        fill,
      );
    }

    // Small decorative dots
    final dotP = Paint()
      ..color = const Color(0xFFD4C4A8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(Offset(cx - 90, cy - 20), 4, dotP);
    canvas.drawCircle(Offset(cx + 110, cy + 15), 3, dotP);
    canvas.drawCircle(Offset(cx - 70, cy + 40), 3, dotP);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
