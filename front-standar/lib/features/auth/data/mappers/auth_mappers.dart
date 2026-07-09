import '../../domain/entities/auth_session.dart';
import '../../domain/entities/verify_reset_code_result.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';
import '../models/verify_reset_code_response.dart';



/// Extension on LoginResponseData to map to AuthSession entity
extension LoginResponseDataMapper on LoginResponseData {
  /// Convert LoginResponseData to AuthSession entity
  AuthSession toEntity() {
    return AuthSession(
      userId: userId,
      token: token,
      refreshToken: refreshToken,
      profilePicture: profilePicture ?? '',
    );
  }
}

/// Extension on RegisterResponseData to map to AuthSession entity
extension RegisterResponseDataMapper on RegisterResponseData {
  /// Convert RegisterResponseData to AuthSession entity
  AuthSession toEntity() {
    return AuthSession(
      userId: userId,
      token: token,
      refreshToken: refreshToken,
      profilePicture: profilePicture ?? '',
    );
  }
}

extension VerifyResetCodeResponseDataMapper on VerifyResetCodeResponseData {
  /// Convert VerifyResetCodeResponseData to VerifyResetCodeResult entity
  VerifyResetCodeResult toEntity() {
    return VerifyResetCodeResult(
      success: true,
      message: 'Code validé avec succès',
      resetToken: resetToken,
    );
  }
}
