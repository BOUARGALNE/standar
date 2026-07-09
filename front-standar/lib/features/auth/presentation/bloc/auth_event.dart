part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  /// Sign in with email and password
  const factory AuthEvent.signInRequested({
    required String email,
    required String password,
  }) = AuthSignInRequested;

  /// Sign out
  const factory AuthEvent.signOutRequested() = AuthSignOutRequested;

  /// Set session externally (e.g. after signup)
  const factory AuthEvent.sessionSet({
    required AuthSession session,
  }) = AuthSessionSet;

  /// Sign in with Google
  const factory AuthEvent.googleSignInRequested() = AuthGoogleSignInRequested;
}
