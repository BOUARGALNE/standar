import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// UseCase for signing in a user
/// Encapsulates the sign-in business logic
class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  /// Execute the sign-in action
  /// Returns an [AuthSession] on success
  Future<AuthSession> call(String email, String password) async {
    return _repository.signIn(email, password);
  }
}
