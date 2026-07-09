import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Intercepteur pour gérer et logger les erreurs globalement
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({
    this.onError401,
    this.onError403,
    this.onError500,
    this.onNetworkError,
  });

  /// Callback pour les erreurs 401 (non autorisé)
  final void Function()? onError401;

  /// Callback pour les erreurs 403 (interdit)
  final void Function()? onError403;

  /// Callback pour les erreurs 500+ (serveur)
  final void Function(String? message)? onError500;

  /// Callback pour les erreurs réseau
  final void Function()? onNetworkError;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log l'erreur en mode debug
    if (kDebugMode) {
      _logError(err);
    }

    // Gère les différents types d'erreurs
    final statusCode = err.response?.statusCode;

    if (statusCode == 401) {
      onError401?.call();
    } else if (statusCode == 403) {
      onError403?.call();
    } else if (statusCode != null && statusCode >= 500) {
      final message = _extractMessage(err.response?.data);
      onError500?.call(message);
    }

    // Gère les erreurs de connexion
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      onNetworkError?.call();
    }

    handler.next(err);
  }

  /// Extrait le message d'erreur de la réponse
  String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is String) return data;
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? data['error'] as String?;
    }
    return null;
  }

  /// Log l'erreur en mode debug
  void _logError(DioException err) {
    debugPrint('═══════════════════════════════════════════════════════════');
    debugPrint('❌ DIO ERROR');
    debugPrint('───────────────────────────────────────────────────────────');
    debugPrint('Type: ${err.type}');
    debugPrint('Message: ${err.message}');
    debugPrint('URL: ${err.requestOptions.uri}');
    debugPrint('Method: ${err.requestOptions.method}');

    if (err.response != null) {
      debugPrint('Status Code: ${err.response?.statusCode}');
      debugPrint('Status Message: ${err.response?.statusMessage}');
      debugPrint('Response Data: ${err.response?.data}');
    }

    debugPrint('═══════════════════════════════════════════════════════════');
  }
}
