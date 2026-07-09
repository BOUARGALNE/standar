import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/networking/exceptions/api_exception.dart';
import '../../../auth/domain/services/token_service.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../domain/usecases/check_auth_usecase.dart';

import '../../../../core/services/secure_storage_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAuthUseCase _checkAuthUseCase;
  final AuthRemoteDataSource _authRemoteDataSource;

  SplashBloc({
    required CheckAuthUseCase checkAuthUseCase,
    required AuthRemoteDataSource authRemoteDataSource,
  })  : _checkAuthUseCase = checkAuthUseCase,
        _authRemoteDataSource = authRemoteDataSource,
        super(const SplashState.initial()) {
    on<SplashStarted>(_onStarted);
  }

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    final hasTokens = await TokenService.instance.loadTokens();

    if (hasTokens) {
      try {
        // Initialize TokenService
        TokenService.instance.initialize(
          dataSource: _authRemoteDataSource,
          onSessionExpired: () {
            final context = AppRouter.rootNavigatorKey.currentContext;
            if (context != null && context.mounted) {
              context.go(AppRoutes.login);
            }
          },
        );

        final isAuthenticated = await _checkAuthUseCase();

        if (isAuthenticated) {
          emit(const SplashState.authenticated());
        } else {
          await TokenService.instance.clearTokens();
          emit(const SplashState.unauthenticated());
        }
      } on ApiException catch (e) {
        if (e.statusCode == 401 || e.statusCode == 403) {
          await TokenService.instance.clearTokens();
          emit(const SplashState.unauthenticated());
        } else {
          emit(SplashState.failure(message: e.message));
        }
      } catch (e) {
        emit(SplashState.failure(message: e.toString()));
      }
    } else {
      final hasSeenOnboarding = await SecureStorageService.instance.getHasSeenOnboarding();
      if (hasSeenOnboarding) {
        emit(const SplashState.unauthenticated());
      } else {
        emit(const SplashState.firstTime());
      }
    }
  }
}
