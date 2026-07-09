import '../../../../core/networking/client/api_client.dart';
import '../../../../core/networking/endpoints/api_endpoints.dart';
import '../../../auth/data/models/check_auth_response.dart';

abstract class SplashRemoteDataSource {
  Future<CheckAuthResponse> checkAuth();
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final ApiClient _apiClient;

  SplashRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CheckAuthResponse> checkAuth() async {
    final response = await _apiClient.get<CheckAuthResponse>(
      ApiEndpoints.checkAuth,
      fromJson: (json) => CheckAuthResponse.fromJson(json as Map<String, dynamic>),
    );

    if (!response.success || response.data == null) {
      throw Exception(response.error ?? 'Failed to check authentication');
    }

    return response.data!;
  }

}
