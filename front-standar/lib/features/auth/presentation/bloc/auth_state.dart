part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  /// Initial state — no authentication attempt has been made
  const factory AuthState.initial() = AuthInitial;

  /// Loading state — authentication is in progress
  const factory AuthState.loading() = AuthLoading;

  /// Success state — user is authenticated
  const factory AuthState.success({
    required AuthSession session,
  }) = AuthSuccess;

  /// Failure state — authentication failed
  const factory AuthState.failure({
    required String message,
  }) = AuthFailure;
}
