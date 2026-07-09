import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// UseCase for signing in with Google
class SignInWithGoogleUseCase {
  const SignInWithGoogleUseCase(this._repository);

  final AuthRepository _repository;

  /// Execute the Google sign-in action
  /// Returns an [AuthSession] on success
  Future<AuthSession> call(String idToken) async {
    return _repository.signInWithGoogle(idToken);
  }
}
