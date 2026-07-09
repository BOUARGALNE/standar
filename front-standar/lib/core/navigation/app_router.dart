import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwl/features/splash/presentation/screens/splash_screen.dart';
import '../../features/splash/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/faq_screen.dart';
import '../ui_kit/theme/app_colors.dart';
import 'app_routes.dart';
import 'scaffold_with_nav_bar.dart';

/// Configuration du router de l'application
class AppRouter {
  AppRouter._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  //static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: _routes,
    errorBuilder: _errorBuilder,
    redirect: _redirect,
  );

  /// Routes de l'application
  static final List<RouteBase> _routes = [
    // Splash Screen
    GoRoute(
      path: AppRoutes.intro,
      name: 'intro',
      builder: (context, state) => const _PlaceholderPage(title: "intro"),
    ),
    // Splash Screen
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // Auth routes
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: 'forgotPassword',
      builder: (context, state) =>
          const _PlaceholderPage(title: "forgotPassword"),
    ),

    // Onboarding
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    GoRoute(
      path: AppRoutes.notifications,
      name: 'notifications',
      builder: (context, state) => const _PlaceholderPage(title: "notifications"),
    ),

    // FAQ
    GoRoute(
      path: AppRoutes.faq,
      name: 'faq',
      builder: (context, state) => const FaqScreen(),
    ),

    // Main App Shell (Bottom Navigation)
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(
          backgroundColor: AppColors.background,
          child: child,
        );
      },
      routes: [
        // VideoOps (Editor)
        GoRoute(
          path: AppRoutes.editor,
          name: 'car',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: _PlaceholderPage(title: "car")),
        ),
        // Profile
        GoRoute(
          path: AppRoutes.profile,
          name: 'profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfileScreen()),
        ),
      ],
    ),
  ];

  /// Gestion des redirections (authf, onboarding, etc.)
  static String? _redirect(BuildContext context, GoRouterState state) {
    return null;
  }

  /// Page d'erreur 404
  static Widget _errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page non trouvée')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('404', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 8),
            Text(
              'Page non trouvée',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.editor),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    );
  }

  /// Routes publiques (accessibles sans authentification)
  /*   static const List<String> _publicRoutes = [
    AppRoutes.splash,
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.forgotPassword,
    AppRoutes.onboarding,
  ]; */
}

/// Page placeholder temporaire pour les routes non encore implémentées
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text('Page en construction...'),
          ],
        ),
      ),
    );
  }
}

