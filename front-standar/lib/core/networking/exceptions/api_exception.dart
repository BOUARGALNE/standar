/// Types d'erreurs API
enum ApiExceptionType {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  validation,
  server,
  cancelled,
  unknown,
}

/// Exception personnalisée pour les erreurs API
class ApiException implements Exception {
  const ApiException({
    required this.type,
    required this.message,
    this.statusCode,
    this.originalException,
    this.data,
  });

  /// Erreur réseau
  factory ApiException.network({
    required String message,
    Object? originalException,
  }) {
    return ApiException(
      type: ApiExceptionType.network,
      message: message,
      originalException: originalException,
    );
  }

  /// Timeout
  factory ApiException.timeout({
    required String message,
    Object? originalException,
  }) {
    return ApiException(
      type: ApiExceptionType.timeout,
      message: message,
      originalException: originalException,
    );
  }

  /// Non autorisé (401)
  factory ApiException.unauthorized({
    required String message,
    int? statusCode = 401,
    Object? originalException,
  }) {
    return ApiException(
      type: ApiExceptionType.unauthorized,
      message: message,
      statusCode: statusCode,
      originalException: originalException,
    );
  }

  /// Interdit (403)
  factory ApiException.forbidden({
    required String message,
    Object? originalException,
  }) {
    return ApiException(
      type: ApiExceptionType.forbidden,
      message: message,
      statusCode: 403,
      originalException: originalException,
    );
  }

  /// Non trouvé (404)
  factory ApiException.notFound({
    required String message,
    Object? originalException,
  }) {
    return ApiException(
      type: ApiExceptionType.notFound,
      message: message,
      statusCode: 404,
      originalException: originalException,
    );
  }

  /// Erreur de validation (422)
  factory ApiException.validation({
    required String message,
    int? statusCode,
    Object? originalException,
    Map<String, dynamic>? data,
  }) {
    return ApiException(
      type: ApiExceptionType.validation,
      message: message,
      statusCode: statusCode ?? 422,
      originalException: originalException,
      data: data,
    );
  }

  /// Erreur serveur (5xx)
  factory ApiException.server({
    required String message,
    required int statusCode,
    Object? originalException,
  }) {
    return ApiException(
      type: ApiExceptionType.server,
      message: message,
      statusCode: statusCode,
      originalException: originalException,
    );
  }

  /// Requête annulée
  factory ApiException.cancelled({
    required String message,
    Object? originalException,
  }) {
    return ApiException(
      type: ApiExceptionType.cancelled,
      message: message,
      originalException: originalException,
    );
  }

  /// Erreur inconnue
  factory ApiException.unknown({
    required String message,
    int? statusCode,
    Object? originalException,
  }) {
    return ApiException(
      type: ApiExceptionType.unknown,
      message: message,
      statusCode: statusCode,
      originalException: originalException,
    );
  }

  /// Type d'erreur
  final ApiExceptionType type;

  /// Message d'erreur lisible
  final String message;

  /// Code HTTP (si applicable)
  final int? statusCode;

  /// Exception originale
  final Object? originalException;

  /// Données supplémentaires (erreurs de validation, etc.)
  final Map<String, dynamic>? data;

  /// Vérifie si l'erreur est due au réseau
  bool get isNetworkError =>
      type == ApiExceptionType.network || type == ApiExceptionType.timeout;

  /// Vérifie si l'utilisateur doit se reconnecter
  bool get requiresReauth => type == ApiExceptionType.unauthorized;

  @override
  String toString() =>
      'ApiException(type: $type, message: $message, statusCode: $statusCode)';
}
