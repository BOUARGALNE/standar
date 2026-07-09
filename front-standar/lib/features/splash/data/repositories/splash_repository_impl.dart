import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_remote_datasource.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource _remoteDataSource;

  SplashRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> checkAuth() async {
    final response = await _remoteDataSource.checkAuth();
    return response.authenticated;
  }

}
