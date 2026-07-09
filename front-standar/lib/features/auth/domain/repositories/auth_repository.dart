import '../entities/auth_session.dart';
import '../entities/verify_reset_code_result.dart';

/// Auth Repository Interface
abstract class AuthRepository {
  /// Sign in with email and password
  Future<AuthSession> signIn(String email, String password);

  /// Sign out the current user
  Future<void> signOut();

  /// Sign in with Google id_token
  Future<AuthSession> signInWithGoogle(String idToken);

  /// Send email verification code
  Future<bool> sendEmailVerificationCode(String email);

  /// Verify email code
  Future<void> verifyEmailCode(String email, String code);

  /// Register a new user
  Future<AuthSession> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String country,
  });

  /// Send forgot password email
  Future<bool> forgotPassword(String email);

  /// Verify OTP code for forgot password
  Future<VerifyResetCodeResult> verifyResetCode(String email, String code);

  /// Reset password
  Future<bool> resetPassword({
    required String email,
    required String otpCode,
    required String newPassword,
    required String confirmPassword,
  });
}
