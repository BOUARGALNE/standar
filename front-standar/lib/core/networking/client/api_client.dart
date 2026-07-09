import 'dart:io';
import 'package:dio/dio.dart';

import '../exceptions/api_exception.dart';
import '../../models/api_response.dart';
import 'dio_client.dart';


/// Client API abstrait pour effectuer les requêtes HTTP
class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? DioClient.instance.dio;

  final Dio _dio;

  /// GET request
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJson,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST request
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJson,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT request
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJson,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PATCH request
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJson,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE request
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic json)? fromJson,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Requête POST avec multipart pour l'upload de fichiers multiples et champs
  Future<ApiResponse<T>> postMultipart<T>(
    String path, {
    Map<String, String>? fields,
    Map<String, File>? files,
    T Function(dynamic json)? fromJson,
    void Function(int sent, int total)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {};

      // Add fields
      if (fields != null) {
        formDataMap.addAll(fields);
      }

      // Add files
      if (files != null) {
        for (final entry in files.entries) {
          formDataMap[entry.key] = await MultipartFile.fromFile(
            entry.value.path,
          );
        }
      }

      final formData = FormData.fromMap(formDataMap);

      final response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(contentType: 'multipart/form-data'),
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Requête PUT avec multipart pour l'upload de fichiers multiples et champs
  Future<ApiResponse<T>> putMultipart<T>(
    String path, {
    Map<String, String>? fields,
    Map<String, File>? files,
    T Function(dynamic json)? fromJson,
    void Function(int sent, int total)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {};

      // Add fields
      if (fields != null) {
        formDataMap.addAll(fields);
      }

      // Add files
      if (files != null) {
        for (final entry in files.entries) {
          formDataMap[entry.key] = await MultipartFile.fromFile(
            entry.value.path,
          );
        }
      }

      final formData = FormData.fromMap(formDataMap);

      final response = await _dio.put(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(contentType: 'multipart/form-data'),
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Upload de fichier avec multipart
  Future<ApiResponse<T>> uploadFile<T>(
    String path, {
    required String filePath,
    required String fieldName,
    Map<String, dynamic>? additionalData,
    T Function(dynamic json)? fromJson,
    void Function(int sent, int total)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
        if (additionalData != null) ...additionalData,
      });

      final response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(contentType: 'multipart/form-data'),
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Téléchargement de fichier
  Future<void> downloadFile(
    String url,
    String savePath, {
    void Function(int received, int total)? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Traite la réponse et la convertit en ApiResponse
  ApiResponse<T> _handleResponse<T>(
    Response response,
    T Function(dynamic json)? fromJson,
  ) {
    final statusCode = response.statusCode ?? 0;
    final responseData = response.data;

    if (statusCode >= 200 && statusCode < 300) {
      // If the response body is a map with the standard envelope
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('success')) {
        return ApiResponse.fromJson(
          responseData,
          fromJsonT: fromJson,
        );
      }

      // If the response is raw data without the envelope
      T? data;
      if (fromJson != null && responseData != null) {
        data = fromJson(responseData);
      } else if (responseData is T) {
        data = responseData;
      }

      return ApiResponse<T>.success(data: data);
    }

    return ApiResponse<T>.error(
      error: _extractErrorMessage(responseData),
    );
  }

  /// Extrait le message d'erreur de la réponse
  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;
    if (data is String) return data;
    if (data is Map<String, dynamic>) {
      // New format: { "error": "message" } or { "error": { "message": "..." } }
      final error = data['error'];
      if (error is String) return error;
      if (error is Map) return error['message'] as String? ?? error.toString();
      // Fallback
      return data['message'] as String? ?? data['errors']?.toString();
    }
    return data.toString();
  }

  /// Convertit DioException en ApiException
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException.timeout(
          message: 'La connexion a expiré. Veuillez réessayer.',
          originalException: error,
        );
      case DioExceptionType.connectionError:
        return ApiException.network(
          message: 'Erreur de connexion. Vérifiez votre connexion internet.',
          originalException: error,
        );
      case DioExceptionType.badCertificate:
        return ApiException.server(
          message: 'Certificat SSL invalide.',
          statusCode: 0,
          originalException: error,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final message = _extractErrorMessage(error.response?.data);

        if (statusCode == 401) {
          return ApiException.unauthorized(
            message: message ?? 'Non autorisé. Veuillez vous reconnecter.',
            originalException: error,
          );
        }
        if (statusCode == 403) {
          return ApiException.forbidden(
            message: message ?? 'Accès refusé.',
            originalException: error,
          );
        }
        if (statusCode == 404) {
          return ApiException.notFound(
            message: message ?? 'Ressource non trouvée.',
            originalException: error,
          );
        }
        if (statusCode == 422) {
          return ApiException.validation(
            message: message ?? 'Erreur de validation.',
            statusCode: statusCode,
            originalException: error,
          );
        }
        if (statusCode >= 500) {
          return ApiException.server(
            message: message ?? 'Erreur serveur. Veuillez réessayer plus tard.',
            statusCode: statusCode,
            originalException: error,
          );
        }

        return ApiException.unknown(
          message: message ?? 'Une erreur est survenue.',
          statusCode: statusCode,
          originalException: error,
        );
      case DioExceptionType.cancel:
        return ApiException.cancelled(
          message: 'Requête annulée.',
          originalException: error,
        );
      case DioExceptionType.unknown:
      return ApiException.unknown(
          message: error.message ?? 'Une erreur inconnue est survenue.',
          originalException: error,
        );
    }
  }
}
