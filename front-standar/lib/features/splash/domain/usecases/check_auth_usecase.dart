import '../repositories/splash_repository.dart';

class CheckAuthUseCase {
  final SplashRepository _repository;

  CheckAuthUseCase(this._repository);

  Future<bool> call() {
    return _repository.checkAuth();
  }
}
