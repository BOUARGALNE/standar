import '../repositories/auth_repository.dart';

/// UseCase for signing out a user
/// Encapsulates the sign-out business logic
class SignOutUseCase {
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  /// Execute the sign-out action
  Future<void> call() async {
    return _repository.signOut();
  }
}
