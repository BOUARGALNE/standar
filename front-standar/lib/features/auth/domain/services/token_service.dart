import '../../../../core/networking/client/dio_client.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../data/datasources/auth_remote_datasource.dart';

/// Service for managing authentication tokens
///
/// Handles token persistence, refresh callback configuration,
/// and automatic token refresh on 401 errors.
class TokenService {
  TokenService._internal();

  static final TokenService _instance = TokenService._internal();
  static TokenService get instance => _instance;

  AuthRemoteDataSource? _dataSource;
  void Function()? _onSessionExpired;

  /// Initialize the token service
  ///
  /// - [dataSource] for making refresh API calls
  /// - [onSessionExpired] called when refresh fails (redirect to login)
  void initialize({
    required AuthRemoteDataSource dataSource,
    required void Function() onSessionExpired,
  }) {
    _dataSource = dataSource;
    _onSessionExpired = onSessionExpired;

    // Configure DioClient with refresh callback
    DioClient.instance.setOnRefreshFailed(_refreshTokenFailed);
    DioClient.instance.setRefreshTokenCallback(_refreshToken);
    DioClient.instance.setOnRefreshFailed(_handleRefreshFailed);
  }

  /// Save tokens after login/register
  Future<void> saveTokens({
    String? userId,
    required String accessToken,
    String? refreshToken,
  }) async {
    // Save to DioClient (runtime)
    DioClient.instance.setAuthToken(accessToken);
    if (refreshToken != null) {
      DioClient.instance.setRefreshToken(refreshToken);
    }

    // Save to secure storage (persistent)
    await SecureStorageService.instance.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    if (userId != null) {
      await SecureStorageService.instance.setUserId(userId);
    }
  }

  /// Load tokens from secure storage (on app startup)
  Future<bool> loadTokens() async {
    final accessToken = await SecureStorageService.instance.getAccessToken();
    final refreshToken = await SecureStorageService.instance.getRefreshToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      DioClient.instance.setAuthToken(accessToken);
      DioClient.instance.setRefreshToken(refreshToken);
      return true;
    }
    return false;
  }

  /// Clear all tokens (logout)
  Future<void> clearTokens() async {
    DioClient.instance.clearAuthToken();
    await SecureStorageService.instance.clearAll();
  }

  Future<void> _refreshTokenFailed() async {}

  /// Refresh token callback called by AuthInterceptor on 401

  Future<String?> _refreshToken() async {
    final refreshToken =
        DioClient.instance.getRefreshToken() ??
        await SecureStorageService.instance.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    try {
      final newTokens = await _dataSource?.refreshAccessToken(refreshToken);

      if (newTokens != null) {
        // Update tokens
        await saveTokens(
          accessToken: newTokens.accessToken,
          refreshToken:
              newTokens.refreshToken, // Update with new refresh token!
        );
        return newTokens.accessToken;
      }
    } catch (e) {
      // Refresh failed
      return null;
    }

    return null;
  }

  /// Called when refresh fails
  void _handleRefreshFailed() {
    clearTokens();
    _onSessionExpired?.call();
  }
}
