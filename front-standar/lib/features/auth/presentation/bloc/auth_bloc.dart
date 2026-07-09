import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:siwl/core/navigation/app_router.dart';

import '../../../../core/networking/client/dio_client.dart';
import '../../../../core/networking/exceptions/api_exception.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/services/token_service.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

/// Bloc for authentication actions.
///
/// Follows the proper Bloc pattern with Event → State.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignOutUseCase signOutUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required AuthRemoteDataSource remoteDataSource,
  })  : _signInUseCase = signInUseCase,
        _signOutUseCase = signOutUseCase,
        _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _remoteDataSource = remoteDataSource,
        super(const AuthState.initial()) {
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthSessionSet>(_onSessionSet);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
  }

  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final AuthRemoteDataSource _remoteDataSource;

  // ── Event handlers ─────────────────────────────────────────────────────────

  Future<void> _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    try {
      final session = await _signInUseCase(event.email, event.password);

      // Set the auth token in DioClient for subsequent requests
      DioClient.instance.setAuthToken(session.token);

      // Save tokens for persistence and refresh
      await TokenService.instance.saveTokens(
        userId: session.userId,
        accessToken: session.token,
        refreshToken: session.refreshToken,
      );

      // Initialize refresh mechanism for this session
      TokenService.instance.initialize(
        dataSource: _remoteDataSource,
        onSessionExpired: () {
          add(const AuthEvent.signOutRequested());
        },
      );

      emit(AuthState.success(session: session));
    } on ApiException catch (e) {
      emit(AuthState.failure(message: e.message));
    } catch (e) {
      emit(AuthState.failure(message: e.toString()));
    }
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    try {
      // 1. Clear any previous Google session to avoid "account reauth failed"
      try {
        await GoogleSignIn.instance.disconnect();
      } catch (_) {
        // Ignore if no previous session exists
      }

      // 2. Trigger Google Sign-In SDK (v7.x API)
      final googleUser = await GoogleSignIn.instance.authenticate();

      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null || idToken.isEmpty) {
        emit(const AuthState.failure(message: 'Failed to retrieve Google ID token'));
        return;
      }
      // 3. Send id_token to backend
      final session = await _signInWithGoogleUseCase(idToken);

      // 4. Set auth token and save tokens
      DioClient.instance.setAuthToken(session.token);

      await TokenService.instance.saveTokens(
        userId: session.userId,
        accessToken: session.token,
        refreshToken: session.refreshToken,
      );

      // 5. Initialize refresh mechanism
      TokenService.instance.initialize(
        dataSource: _remoteDataSource,
        onSessionExpired: () {
          add(const AuthEvent.signOutRequested());
        },
      );

      emit(AuthState.success(session: session));
    } on ApiException catch (e) {
      emit(AuthState.failure(message: e.message));
    } catch (e) {
      debugPrint('[AuthBloc] Google sign-in error: $e');
      emit(const AuthState.failure(message: 'Google sign-in failed. Please try again.'));
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _signOutUseCase();
    await TokenService.instance.clearTokens();
    AppRouter.router.goNamed("login");
    emit(const AuthState.initial());
  }

  void _onSessionSet(
    AuthSessionSet event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthState.success(session: event.session));
  }

  // ── Convenience getters ────────────────────────────────────────────────────

  /// Check if user is authenticated
  bool get isAuthenticated => state is AuthSuccess;

  /// Get current session if authenticated
  AuthSession? get currentSession {
    return state.mapOrNull(
      success: (s) => s.session,
    );
  }
}

