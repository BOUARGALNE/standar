import 'package:dio/dio.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

/// Intercepteur pour gérer l'authentification et le refresh token
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.getToken,
    required this.refreshToken,
    required this.onTokenRefreshed,
  });

  /// Callback pour récupérer le token actuel
  final String? Function() getToken;

  /// Callback pour rafraîchir le token
  final Future<String?> Function()? refreshToken;

  /// Callback appelé quand le token est rafraîchi
  final void Function(String token) onTokenRefreshed;

  /// Indique si un refresh est en cours
  bool _isRefreshing = false;

  /// Queue des requêtes en attente pendant le refresh
  final List<_RequestRetry> _pendingRequests = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Skip 401 handling for refresh-token endpoint to prevent infinite loop
    final isRefreshTokenRequest = err.requestOptions.path.contains(
      'refresh-token',
    );

    // Vérifie si l'erreur est une 401 (Unauthorized)
    if ((err.response?.statusCode == 401 || err.response?.statusCode == 403 ) &&
        refreshToken != null &&
        !isRefreshTokenRequest) {
      // Évite les refresh multiples simultanés
      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          final newToken = await refreshToken!();

          if (newToken != null && newToken.isNotEmpty) {
            onTokenRefreshed(newToken);

            // Réessaie la requête originale avec le nouveau token
            final response = await _retryRequest(err.requestOptions, newToken);

            // Traite les requêtes en attente
            _processQueue(newToken);

            _isRefreshing = false;
            return handler.resolve(response);
          }
        } catch (e) {
          debugPrint('[AuthInterceptor] Error during refresh/retry: $e');
          _isRefreshing = false;
          _rejectQueue(err);
          return handler.next(err);
        }

        _isRefreshing = false;
      } else {
        // Ajoute la requête à la queue si un refresh est déjà en cours
        final completer = _RequestRetry(err.requestOptions);
        _pendingRequests.add(completer);

        try {
          final response = await completer.future;
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }

    handler.next(err);
  }

  /// Réessaie une requête avec un nouveau token
  Future<Response> _retryRequest(RequestOptions options, String token) async {
    options.headers['Authorization'] = 'Bearer $token';

    final dio = Dio(
      BaseOptions(baseUrl: options.baseUrl, headers: options.headers),
    );

    return dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(
        method: options.method,
        headers: options.headers,
        contentType: options.contentType,
      ),
    );
  }

  /// Traite les requêtes en attente
  void _processQueue(String token) {
    for (final request in _pendingRequests) {
      _retryRequest(request.options, token).then(
        (response) => request.complete(response),
        onError: (error) => request.completeError(error),
      );
    }
    _pendingRequests.clear();
  }

  /// Rejette toutes les requêtes en attente
  void _rejectQueue(DioException error) {
    for (final request in _pendingRequests) {
      request.completeError(error);
    }
    _pendingRequests.clear();
  }
}

/// Classe pour gérer les requêtes en attente
class _RequestRetry {
  _RequestRetry(this.options);

  final RequestOptions options;
  final _completer = Completer<Response>();

  Future<Response> get future => _completer.future;

  void complete(Response response) {
    if (!_completer.isCompleted) {
      _completer.complete(response);
    }
  }

  void completeError(Object error) {
    if (!_completer.isCompleted) {
      _completer.completeError(error);
    }
  }
}

// Import nécessaire pour Completer
