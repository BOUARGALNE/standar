import '../entities/user.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  const GetProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<User> call() {
    return _repository.getProfile();
  }
}
