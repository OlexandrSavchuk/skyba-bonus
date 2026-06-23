import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_theme.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/core/utils/validators.dart';
import 'package:skyba_bonus/features/auth/data/models/register_request.dart';
import 'package:skyba_bonus/features/auth/domain/auth_state.dart';
import 'package:skyba_bonus/features/auth/providers/auth_provider.dart';
import 'package:skyba_bonus/features/auth/providers/companies_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Прийміть правила користування'),
        backgroundColor: AppColors.error,
      ));
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      final companiesState = ref.read(companiesProvider);
      final companies = companiesState.valueOrNull;
      final company = companies?.firstOrNull;
      if (company == null) {
        // Retry fetching companies
        ref.invalidate(companiesProvider);
        final errorMsg = companiesState.error?.toString() ?? '';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMsg.isNotEmpty
              ? 'Помилка з\'єднання: $errorMsg'
              : 'Немає доступних регіонів. Перевірте інтернет.'),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 5),
        ));
        return;
      }
      final parts = _nameController.text.trim().split(' ');
      ref.read(authProvider.notifier).register(RegisterRequest(
        companyId: company.id,
        firstName: parts.isNotEmpty ? parts.first : _nameController.text.trim(),
        lastName: parts.length > 1 ? parts.last : null,
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    // Eagerly start fetching companies so they're ready when user presses register
    final companiesAsync = ref.watch(companiesProvider);

    ref.listen<AuthState>(authProvider, (_, next) {
      next.maybeWhen(
        error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: AppColors.error),
        ),
        orElse: () {},
      );
    });

    final isLoading = authState.maybeWhen(loading: () => true, orElse: () => false);

    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: AppColors.creamBg,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 48),
                        Text('Приєднуйтесь до Скиби',
                            style: AppTypography.headlineMediumLight),
                        const SizedBox(height: 8),
                        Text(
                          'Зареєструйтесь щоб користуватися додатком',
                          style: AppTypography.bodyMediumLight.copyWith(
                            color: AppColors.textDarkSecondary,
                          ),
                        ),
                        const SizedBox(height: 32),

                        _CreamField(
                          label: "Ім'я",
                          hint: 'Введіть ваше ім\'я',
                          controller: _nameController,
                          enabled: !isLoading,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? "Введіть ім'я" : null,
                        ),
                        const SizedBox(height: 16),
                        _CreamField(
                          label: 'Електронна адреса',
                          hint: 'Введіть свою електронну адресу',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          enabled: !isLoading,
                          validator: Validators.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        _CreamField(
                          label: 'Номер телефону',
                          hint: 'Введіть номер телефону',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          enabled: !isLoading,
                          validator: Validators.validatePhone,
                        ),
                        const SizedBox(height: 16),
                        _CreamField(
                          label: 'Пароль',
                          hint: 'Введіть пароль',
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          enabled: !isLoading,
                          validator: Validators.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textDarkSecondary,
                            ),
                            onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _CreamField(
                          label: 'Підтвердьте пароль',
                          hint: 'Введіть пароль повторно',
                          controller: _confirmController,
                          obscureText: _obscureConfirm,
                          enabled: !isLoading,
                          validator: (v) => v != _passwordController.text
                              ? 'Паролі не співпадають'
                              : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textDarkSecondary,
                            ),
                            onPressed: () => setState(
                                () => _obscureConfirm = !_obscureConfirm),
                          ),
                        ),
                        const SizedBox(height: 24),

                        _OrDivider(),
                        const SizedBox(height: 24),
                        _SocialButtons(),
                        const SizedBox(height: 24),

                        // Terms checkbox
                        GestureDetector(
                          onTap: () =>
                              setState(() => _agreeTerms = !_agreeTerms),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 24, height: 24,
                                child: Checkbox(
                                  value: _agreeTerms,
                                  onChanged: (v) => setState(
                                      () => _agreeTerms = v ?? false),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  side: const BorderSide(
                                      color: AppColors.borderCream, width: 1.5),
                                  activeColor: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text.rich(TextSpan(
                                  text: 'Я погоджуюся з ',
                                  style: AppTypography.bodySmallLight.copyWith(
                                    color: AppColors.textDarkSecondary,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Правилами',
                                      style: AppTypography.bodySmallLight
                                          .copyWith(
                                        color: AppColors.textDark,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\nкористування додатком',
                                      style: AppTypography.bodySmallLight
                                          .copyWith(
                                              color: AppColors.textDarkSecondary),
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        Center(
                          child: Text.rich(TextSpan(
                            text: 'Вже маєте акаунт? ',
                            style: AppTypography.bodyMediumLight.copyWith(
                              color: AppColors.textDarkSecondary,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: GestureDetector(
                                  onTap: isLoading ? null : () => context.pop(),
                                  child: Text('Увійти',
                                      style: AppTypography.bodyMediumLight
                                          .copyWith(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                              ),
                            ],
                          )),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: ElevatedButton(
                  onPressed: (_agreeTerms && !isLoading) ? _onRegister : null,
                  child: isLoading
                      ? const SizedBox(
                          width: 24, height: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.cream, strokeWidth: 2))
                      : const Text('Продовжити'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreamField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const _CreamField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        validator: validator,
        style: TextStyle(color: AppColors.textDark),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: suffixIcon,
        ),
      );
}

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Expanded(child: Divider(color: AppColors.borderCream)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('або',
                style: AppTypography.bodySmallLight
                    .copyWith(color: AppColors.textDarkSecondary)),
          ),
          const Expanded(child: Divider(color: AppColors.borderCream)),
        ],
      );
}

class _SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SocBtn(child: Text('f',
              style: TextStyle(color: Colors.white, fontSize: 22,
                  fontWeight: FontWeight.w700))),
          const SizedBox(width: 16),
          _SocBtn(child: const Icon(Icons.apple, color: Colors.white, size: 26)),
          const SizedBox(width: 16),
          _SocBtn(child: Text('G',
              style: TextStyle(color: Colors.white, fontSize: 20,
                  fontWeight: FontWeight.w700))),
        ],
      );
}

class _SocBtn extends StatelessWidget {
  final Widget child;
  const _SocBtn({required this.child});

  @override
  Widget build(BuildContext context) => Container(
        width: 52, height: 52,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: child,
      );
}
