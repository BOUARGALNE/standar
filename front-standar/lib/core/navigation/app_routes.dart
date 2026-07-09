/// Noms des routes de l'application
abstract class AppRoutes {
  // Routes principales
  static const String intro = '/intro';

  static const String splash = '/';
  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Onboarding
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';

  // Main tabs
  static const String editor = '/editor';
  static const String profile = '/profile';
  static const String notifications = '/notifications';


  // Profile sub-routes
  static const String changePassword = '/change-password';
  static const String faq = '/faq';

}
