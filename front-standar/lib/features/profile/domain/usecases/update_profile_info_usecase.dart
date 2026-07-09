import '../entities/user.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileInfoUseCase {
  const UpdateProfileInfoUseCase(this._repository);

  final ProfileRepository _repository;

  Future<User> call({String? firstName, String? lastName, String? phone, String? country}) {
    return _repository.updateProfileInfo(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      country: country,
    );
  }
}
