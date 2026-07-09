/// Réponse API générique
///
/// Format attendu du serveur :
/// ```json
/// {
///   "success": true,
///   "data": { ... },
///   "error": null
/// }
/// ```
class ApiResponse<T> {
  const ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.meta,
  });

  /// Indique si la requête a réussi
  final bool success;

  /// Données de la réponse (null en cas d'erreur)
  final T? data;

  /// Message d'erreur (null en cas de succès)
  final String? error;

  /// Métadonnées (pagination, etc.)
  final ApiMeta? meta;

  /// Crée une réponse de succès
  factory ApiResponse.success({T? data, ApiMeta? meta}) {
    return ApiResponse(
      success: true,
      data: data,
      error: null,
      meta: meta,
    );
  }

  /// Crée une réponse d'erreur
  factory ApiResponse.error({String? error}) {
    return ApiResponse(
      success: false,
      error: error,
    );
  }

  /// Parse une réponse JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic)? fromJsonT,
  }) {
    // Extract error — can be a string, a map, or null
    String? error;
    final rawError = json['error'];
    if (rawError is String) {
      error = rawError;
    } else if (rawError is Map) {
      error = rawError['message'] as String? ?? rawError.toString();
    }

    return ApiResponse(
      success: json['success'] as bool? ?? true,
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      error: error,
      meta: json['meta'] != null
          ? ApiMeta.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Convertit en Map
  Map<String, dynamic> toJson({Map<String, dynamic> Function(T)? toJsonT}) {
    return {
      'success': success,
      'data': data != null && toJsonT != null ? toJsonT(data as T) : data,
      'error': error,
      if (meta != null) 'meta': meta!.toJson(),
    };
  }

  /// Copie avec modifications
  ApiResponse<T> copyWith({
    bool? success,
    T? data,
    String? error,
    ApiMeta? meta,
  }) {
    return ApiResponse<T>(
      success: success ?? this.success,
      data: data ?? this.data,
      error: error ?? this.error,
      meta: meta ?? this.meta,
    );
  }

  @override
  String toString() =>
      'ApiResponse(success: $success, data: $data, error: $error, meta: $meta)';
}

/// Métadonnées de pagination
class ApiMeta {
  const ApiMeta({this.currentPage, this.lastPage, this.perPage, this.total});

  /// Page actuelle
  final int? currentPage;

  /// Dernière page
  final int? lastPage;

  /// Éléments par page
  final int? perPage;

  /// Total d'éléments
  final int? total;

  /// Vérifie s'il y a une page suivante
  bool get hasNextPage =>
      currentPage != null && lastPage != null && currentPage! < lastPage!;

  /// Vérifie s'il y a une page précédente
  bool get hasPreviousPage => currentPage != null && currentPage! > 1;

  factory ApiMeta.fromJson(Map<String, dynamic> json) {
    return ApiMeta(
      currentPage: json['current_page'] as int? ?? json['currentPage'] as int?,
      lastPage: json['last_page'] as int? ?? json['lastPage'] as int?,
      perPage: json['per_page'] as int? ?? json['perPage'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (currentPage != null) 'current_page': currentPage,
      if (lastPage != null) 'last_page': lastPage,
      if (perPage != null) 'per_page': perPage,
      if (total != null) 'total': total,
    };
  }

  @override
  String toString() =>
      'ApiMeta(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total)';
}

/// Réponse paginée
class PaginatedResponse<T> {
  const PaginatedResponse({required this.items, required this.meta});

  /// Liste des éléments
  final List<T> items;

  /// Métadonnées de pagination
  final ApiMeta meta;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dataList = json['data'] as List<dynamic>? ?? [];
    return PaginatedResponse(
      items: dataList
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      meta: ApiMeta.fromJson(json['meta'] as Map<String, dynamic>? ?? {}),
    );
  }

  @override
  String toString() => 'PaginatedResponse(items: ${items.length}, meta: $meta)';
}
