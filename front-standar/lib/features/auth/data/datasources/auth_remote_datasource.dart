import 'package:dio/dio.dart';

import '../../../../core/networking/client/api_client.dart';
import '../../../../core/networking/endpoints/api_endpoints.dart';
import '../../../../core/networking/exceptions/api_exception.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';
import '../models/send_verification_code_request.dart';
import '../models/verify_code_request.dart';
import '../models/refresh_token_response.dart';
import '../models/forgot_password_request.dart';
import '../models/register_request.dart';
import '../models/verify_reset_code_request.dart';
import '../models/verify_reset_code_response.dart';
import '../models/reset_password_request.dart';

/// Auth Remote Data Source
abstract class AuthRemoteDataSource {
  /// Sign in with email and password
  Future<LoginResponseData> signIn(LoginRequest request);

  /// Send email verification code
  Future<void> sendEmailVerificationCode(String email);

  /// Verify email code
  Future<void> verifyEmailCode(String email, String code);

  /// Register a new user
  Future<RegisterResponseData> register(RegisterRequest request);

  /// Refresh access token using refresh token
  Future<RefreshTokenData> refreshAccessToken(String refreshToken);

  /// Send forgot password email
  Future<void> forgotPassword(ForgotPasswordRequest request);

  /// Verify OTP code for forgot password
  Future<VerifyResetCodeResponseData> verifyResetCode(VerifyResetCodeRequest request);

  /// Reset password
  Future<void> resetPassword(ResetPasswordRequest request);

  /// Sign in with Google id_token
  Future<LoginResponseData> signInWithGoogle(String idToken);

  /// Sign out (invalidate token on server)
  Future<void> signOut();
}

/// Implementation of [AuthRemoteDataSource]
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<LoginResponseData> signIn(LoginRequest request) async {
    final response = await _apiClient.post<LoginResponseData>(
      ApiEndpoints.login,
      data: request.toJson(),
      options: Options(contentType: Headers.formUrlEncodedContentType),
      fromJson: (json) => LoginResponseData.fromJson(json as Map<String, dynamic>),
    );

    if (response.success && response.data != null) {
      return response.data!;
    }

    throw ApiException.unknown(
      message: response.error ?? 'Échec de la connexion',
    );
  }

  @override
  Future<void> sendEmailVerificationCode(String email) async {
    final request = SendEmailVerificationRequest(email: email);

    final response = await _apiClient.post<void>(
      ApiEndpoints.sendEmailVerificationCode,
      data: request.toJson(),
    );

    if (response.success) return;

    throw ApiException.unknown(
      message: response.error ?? 'Échec de l\'envoi du code de vérification',
    );
  }


  @override
  Future<void> verifyEmailCode(
    String email,
    String code,
  ) async {
    final request = VerifyEmailCodeRequest(email: email, code: code);

    final response = await _apiClient.post<void>(
      ApiEndpoints.verifyEmailCode,
      data: request.toJson(),
    );

    if (response.success) {
      return;
    }

    throw ApiException.unknown(
      message: response.error ?? 'Échec de la vérification du code',
    );
  }


  @override
  Future<RegisterResponseData> register(RegisterRequest request) async {
    final response = await _apiClient.post<RegisterResponseData>(
      ApiEndpoints.register,
      data: request.toJson(),
      fromJson: (json) =>
          RegisterResponseData.fromJson(json as Map<String, dynamic>),
    );

    if (response.success && response.data != null) {
      return response.data!;
    }

    throw ApiException.unknown(
      message: response.error ?? 'Échec de l\'inscription',
    );
  }

  @override
  Future<RefreshTokenData> refreshAccessToken(String refreshToken) async {
    final response = await _apiClient.post<RefreshTokenData>(
      ApiEndpoints.refreshToken,
      data: {'refresh_token': refreshToken},
      fromJson: (json) =>
          RefreshTokenData.fromJson(json as Map<String, dynamic>),
    );

    if (response.success && response.data != null) {
      return response.data!;
    }

    throw ApiException.unauthorized(
      message: response.error ?? 'Session expirée',
    );
  }

  @override
  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    final response = await _apiClient.post<void>(
      ApiEndpoints.forgotPassword,
      data: request.toJson(),
    );

    if (response.success) return;

    throw ApiException.unknown(
      message: response.error ?? 'Échec de l\'envoi du code de réinitialisation',
    );
  }

  @override
  Future<VerifyResetCodeResponseData> verifyResetCode(VerifyResetCodeRequest request) async {
    final response = await _apiClient.post<VerifyResetCodeResponseData>(
      ApiEndpoints.verifyResetCode,
      data: request.toJson(),
      fromJson: (json) =>
          VerifyResetCodeResponseData.fromJson(json as Map<String, dynamic>),
    );

    if (response.success && response.data != null) {
      return response.data!;
    }

    throw ApiException.unknown(
      message: response.error ?? 'Échec de la vérification du code',
    );
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    final response = await _apiClient.post<void>(
      ApiEndpoints.resetPassword,
      data: request.toJson(),
    );

    if (response.success) return;

    throw ApiException.unknown(
      message: response.error ?? 'Échec de la réinitialisation du mot de passe',
    );
  }

  @override
  Future<LoginResponseData> signInWithGoogle(String idToken) async {
    final response = await _apiClient.post<LoginResponseData>(
      ApiEndpoints.googleLogin,
      data: {'id_token': idToken},
      fromJson: (json) => LoginResponseData.fromJson(json as Map<String, dynamic>),
    );

    if (response.success && response.data != null) {
      return response.data!;
    }

    throw ApiException.unknown(
      message: response.error ?? 'Google sign-in failed',
    );
  }

  @override
  Future<void> signOut() async {
    final response = await _apiClient.post<void>(
      ApiEndpoints.logout,
      fromJson: (_) {},
    );

    if (!response.success) {
      throw ApiException.unknown(
        message: response.error ?? 'Failed to sign out',
      );
    }
  }
}
