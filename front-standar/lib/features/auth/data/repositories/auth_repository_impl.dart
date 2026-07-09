import '../../../../core/networking/client/dio_client.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/verify_reset_code_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/auth_mappers.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/forgot_password_request.dart';
import '../models/verify_reset_code_request.dart';
import '../models/reset_password_request.dart';

/// Auth Repository Implementation
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthSession> signIn(String email, String password) async {
    final request = LoginRequest(username: email, password: password);
    final response = await _remoteDataSource.signIn(request);
    return response.toEntity();
  }

  @override
  Future<void> signOut() async {
    // Best-effort: invalidate token on server, then clear locally
    try {
      await _remoteDataSource.signOut();
    } catch (_) {
      // Ignore API errors — always clear local token
    }
    DioClient.instance.clearAuthToken();
  }

  @override
  Future<AuthSession> signInWithGoogle(String idToken) async {
    final response = await _remoteDataSource.signInWithGoogle(idToken);
    return response.toEntity();
  }

  @override
  Future<bool> sendEmailVerificationCode(String email) async {
    await _remoteDataSource.sendEmailVerificationCode(email);
    return true;
  }


  @override
  Future<void> verifyEmailCode(String email, String code) async {
    await _remoteDataSource.verifyEmailCode(email, code);
  }

  @override
  Future<AuthSession> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String country,
  }) async {
    final request = RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      password: password,
      country: country,
    );
    final response = await _remoteDataSource.register(request);
    return response.toEntity();
  }

  @override
  Future<bool> forgotPassword(String email) async {
    final request = ForgotPasswordRequest(email: email);
    await _remoteDataSource.forgotPassword(request);
    return true;
  }

  @override
  Future<VerifyResetCodeResult> verifyResetCode(
    String email,
    String code,
  ) async {
    final request = VerifyResetCodeRequest(email: email, code: code);
    final response = await _remoteDataSource.verifyResetCode(request);
    return response.toEntity();
  }

  @override
  Future<bool> resetPassword({
    required String email,
    required String otpCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final request = ResetPasswordRequest(
      email: email,
      otpCode: otpCode,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    await _remoteDataSource.resetPassword(request);
    return true;
  }
}
