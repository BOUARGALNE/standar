part of 'splash_bloc.dart';

@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState.initial() = SplashInitial;
  const factory SplashState.authenticated() = SplashAuthenticated;
  const factory SplashState.unauthenticated() = SplashUnauthenticated;
  const factory SplashState.firstTime() = SplashFirstTime;
  const factory SplashState.failure({required String message}) = SplashFailure;
}
