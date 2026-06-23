import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skyba_bonus/core/router/app_router.dart';
import 'package:skyba_bonus/core/theme/app_theme.dart';

class SkybaApp extends ConsumerWidget {
  const SkybaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Skyba Bonus',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      locale: const Locale('uk', 'UA'),
      supportedLocales: const [
        Locale('uk', 'UA'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
