import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../endpoints/api_endpoints.dart' show ApiEndpoints;
import '../interceptors/auth_interceptor.dart' show AuthInterceptor;
import '../interceptors/error_interceptor.dart' show ErrorInterceptor;


/// Client Dio configuré pour l'application
class DioClient {
  DioClient._internal();

  static final DioClient _instance = DioClient._internal();
  static DioClient get instance => _instance;

  late final Dio _dio;

  /// Getter pour accéder à l'instance Dio
  Dio get dio => _dio;

  /// Token d'authentification
  String? _authToken;

  /// Token de rafraîchissement
  String? _refreshToken;

  /// Callback pour récupérer un nouveau token
  Future<String?> Function()? _refreshTokenCallback;

  /// Callback pour gérer l'échec du refresh (ex: redirection vers login)
  void Function()? _onRefreshFailed;

  /// Initialise le client Dio avec les configurations
  void init({
    String? baseUrl,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    Duration sendTimeout = const Duration(seconds: 30),
    bool enableLogging = true,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiEndpoints.baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        responseType: ResponseType.json,
        //validateStatus: (status) => status != null && status < 500,
      ),
    );

    // Ajout des intercepteurs
    _dio.interceptors.addAll([
      AuthInterceptor(
        getToken: () => _authToken,
        refreshToken: () async {
          final newToken = await _refreshTokenCallback?.call();
          if (newToken == null) {
            _onRefreshFailed?.call();
          }
          return newToken;
        },
        onTokenRefreshed: (token) => _authToken = token,
      ),
      ErrorInterceptor(),
      if (enableLogging)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
    ]);
  }

  /// Configure le token d'authentification
  void setAuthToken(String? token) {
    _authToken = token;
  }

  /// Récupère le token d'authentification actuel
  String? getAuthToken() => _authToken;

  /// Configure le refresh token
  void setRefreshToken(String? token) {
    _refreshToken = token;
  }

  /// Récupère le refresh token actuel
  String? getRefreshToken() => _refreshToken;

  /// Configure le callback de refresh token
  void setRefreshTokenCallback(Future<String?> Function()? callback) {
    _refreshTokenCallback = callback;
  }

  /// Configure le callback appelé quand le refresh échoue
  void setOnRefreshFailed(void Function()? callback) {
    _onRefreshFailed = callback;
  }

  /// Efface les tokens d'authentification
  void clearAuthToken() {
    _authToken = null;
    _refreshToken = null;
  }

  /// Ajoute un intercepteur personnalisé
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// Supprime un intercepteur
  void removeInterceptor(Interceptor interceptor) {
    _dio.interceptors.remove(interceptor);
  }
}
