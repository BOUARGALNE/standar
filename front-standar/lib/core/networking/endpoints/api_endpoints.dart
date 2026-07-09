abstract class ApiEndpoints {
  static const String baseUrl = 'http://10.16.234.69:8000/api/';

  // Auth
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/refresh';
  static const String logout = 'auth/signout';
  static const String googleLogin = 'auth/google';
  static const String checkAuth = 'auth/check';
  static const String forgotPassword = 'auth/forgot-password';
  static const String verifyResetCode = 'auth/verify-reset-code';
  static const String resetPassword = 'auth/reset-password';
  // Verification
  static const String sendEmailVerificationCode = 'auth/send-otp';
  static const String verifyEmailCode = 'auth/verify-otp';

  // Settings
  static const String changePassword = 'profile/change-password';

  // Utils





  // User
  static const String getProfile = 'profile/me';
  static const String deleteAccount = 'profile/delete-account';
  static const String profileAvatar = 'profile/photo';
  static const String updateProfileInfo = 'profile/info';

}