import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skyba_bonus/core/widgets/bottom_nav_shell.dart';
import 'package:skyba_bonus/features/auth/presentation/login_screen.dart';
import 'package:skyba_bonus/features/auth/presentation/register_screen.dart';
import 'package:skyba_bonus/features/auth/presentation/reset_password_screen.dart';
import 'package:skyba_bonus/features/auth/presentation/splash_screen.dart';
import 'package:skyba_bonus/features/auth/presentation/welcome_screen.dart';
import 'package:skyba_bonus/features/auth/providers/auth_provider.dart';
import 'package:skyba_bonus/features/bonus/presentation/bonus_home_screen.dart';
import 'package:skyba_bonus/features/bonus/presentation/qr_code_screen.dart';
import 'package:skyba_bonus/features/content/presentation/content_page_screen.dart';
import 'package:skyba_bonus/features/notifications/presentation/notifications_screen.dart';
import 'package:skyba_bonus/features/profile/presentation/edit_profile_screen.dart';
import 'package:skyba_bonus/features/profile/presentation/profile_screen.dart';
import 'package:skyba_bonus/features/promotions/presentation/promotion_detail_screen.dart';
import 'package:skyba_bonus/features/promotions/presentation/promotions_screen.dart';
import 'package:skyba_bonus/features/shops/presentation/shop_detail_screen.dart';
import 'package:skyba_bonus/features/shops/presentation/shops_list_screen.dart';
import 'package:skyba_bonus/features/transactions/presentation/receipt_detail_screen.dart';
import 'package:skyba_bonus/features/transactions/presentation/transactions_list_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoading = authState.maybeWhen(
        loading: () => true,
        orElse: () => false,
      );
      final isAuthenticated = authState.maybeWhen(
        authenticated: (_, __) => true,
        orElse: () => false,
      );
      final loc = state.matchedLocation;
      final isAuthRoute = loc == '/welcome' ||
          loc == '/login' ||
          loc == '/register' ||
          loc == '/reset-password';

      // Show splash only on initial load (not during login/register)
      if (isLoading && !isAuthRoute && loc != '/splash') return '/splash';
      if (isLoading && loc == '/splash') return null;

      // After load, leave splash
      if (loc == '/splash') {
        return isAuthenticated ? '/home' : '/welcome';
      }

      if (!isAuthenticated && !isAuthRoute) return '/welcome';
      if (isAuthenticated && isAuthRoute) return '/home';
      return null;
    },
    routes: [
      // ── Auth ────────────────────────────────────────────────────────────
      GoRoute(
        path: '/splash',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const ResetPasswordScreen(),
      ),

      // ── Full-screen (no bottom nav) ─────────────────────────────────────
      GoRoute(
        path: '/qr',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const QrCodeScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/pages/about-skyba',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const ContentPageScreen(
          slug: 'about-skyba',
          title: 'Скибоманам про Скибу',
        ),
      ),
      GoRoute(
        path: '/pages/how-to-use',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const ContentPageScreen(
          slug: 'how-to-use',
          title: 'Як використати Скибарики',
        ),
      ),

      // ── Shell (bottom nav) ───────────────────────────────────────────────
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (_, __, child) => BottomNavShell(child: child),
        routes: [
          // Home
          GoRoute(
            path: '/home',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: BonusHomeScreen()),
          ),

          // Promotions
          GoRoute(
            path: '/promotions',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: PromotionsScreen()),
            routes: [
              GoRoute(
                path: ':id',
                builder: (_, state) => PromotionDetailScreen(
                  promotionId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),

          // Notifications
          GoRoute(
            path: '/notifications',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: NotificationsScreen()),
          ),

          // Shops
          GoRoute(
            path: '/shops',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: ShopsListScreen()),
            routes: [
              GoRoute(
                path: ':id',
                builder: (_, state) => ShopDetailScreen(
                  shopId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),

          // Transactions
          GoRoute(
            path: '/transactions',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: TransactionsListScreen()),
            routes: [
              GoRoute(
                path: ':id',
                builder: (_, state) => ReceiptDetailScreen(
                  receiptId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),

          // Profile
          GoRoute(
            path: '/profile',
            pageBuilder: (_, __) =>
                const NoTransitionPage(child: ProfileScreen()),
          ),
        ],
      ),
    ],
  );
});
