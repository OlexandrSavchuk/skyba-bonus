import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_theme.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';
import 'package:skyba_bonus/features/auth/domain/auth_state.dart';
import 'package:skyba_bonus/features/auth/providers/auth_provider.dart';
import 'package:skyba_bonus/features/auth/providers/companies_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _selectedCompanyId;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      final companiesState = ref.read(companiesProvider);
      final companies = companiesState.valueOrNull;

      if (companies == null || companies.isEmpty) {
        ref.invalidate(companiesProvider);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Немає доступних регіонів. Перевірте інтернет.'),
          backgroundColor: AppColors.error,
          duration: Duration(seconds: 5),
        ));
        return;
      }

      final companyId = _selectedCompanyId ?? companies.first.id;

      ref.read(authProvider.notifier).login(
            companyId,
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    // Eagerly start fetching companies so they're ready when user presses login
    final companiesAsync = ref.watch(companiesProvider);

    ref.listen<AuthState>(authProvider, (_, next) {
      next.maybeWhen(
        error: (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.error),
        ),
        orElse: () {},
      );
    });

    final isLoading = authState.maybeWhen(loading: () => true, orElse: () => false);
    final companies = companiesAsync.valueOrNull ?? [];

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
                        Text(
                          'Вже маєте профіль? Увійти',
                          style: AppTypography.headlineMediumLight,
                        ),
                        const SizedBox(height: 32),

                        if (companies.isNotEmpty) ...[
                          DropdownButtonFormField<String>(
                            value: _selectedCompanyId ?? companies.first.id,
                            decoration: const InputDecoration(
                              labelText: 'Регіон',
                            ),
                            dropdownColor: AppColors.creamBg,
                            style: TextStyle(color: AppColors.textDark),
                            items: companies.map((c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(c.region ?? c.name),
                            )).toList(),
                            onChanged: isLoading ? null : (val) {
                              setState(() => _selectedCompanyId = val);
                            },
                          ),
                          const SizedBox(height: 16),
                        ],

                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(color: AppColors.textDark),
                          decoration: const InputDecoration(
                            labelText: 'Електронна адреса',
                            hintText: 'Введіть свою електронну адресу',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          enabled: !isLoading,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Введіть адресу або телефон'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _passwordController,
                          style: TextStyle(color: AppColors.textDark),
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            hintText: 'Введіть свій пароль',
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
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          enabled: !isLoading,
                          onFieldSubmitted: (_) => _onLogin(),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Введіть пароль' : null,
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: isLoading
                                ? null
                                : () => context.push('/reset-password'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textDark,
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Скинути пароль',
                              style: AppTypography.bodySmallLight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        _OrDivider(),
                        const SizedBox(height: 24),
                        _SocialButtons(),
                        const SizedBox(height: 32),
                        _BreadIllustration(),
                        const SizedBox(height: 24),

                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Ви не маєте акаунту? ',
                              style: AppTypography.bodyMediumLight.copyWith(
                                color: AppColors.textDarkSecondary,
                              ),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: GestureDetector(
                                    onTap: isLoading
                                        ? null
                                        : () => context.push('/register'),
                                    child: Text(
                                      'Приєднатися',
                                      style: AppTypography.bodyMediumLight
                                          .copyWith(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                  onPressed: isLoading ? null : _onLogin,
                  child: isLoading
                      ? const SizedBox(
                          width: 24, height: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.cream, strokeWidth: 2),
                        )
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

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
}

class _SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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

class _BreadIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        height: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}
