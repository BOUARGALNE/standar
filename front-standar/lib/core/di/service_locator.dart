import '../networking/client/api_client.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/forgot_password_usecases.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/sign_up_bloc.dart';
import '../../features/auth/presentation/bloc/forgot_password_bloc.dart';

import '../../features/splash/data/datasources/splash_remote_datasource.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/check_auth_usecase.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';

import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/update_profile_photo_usecase.dart';
import '../../features/profile/domain/usecases/update_profile_info_usecase.dart';
import '../../features/profile/domain/usecases/change_password_usecase.dart';
import '../../features/profile/domain/usecases/delete_account_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

import '../services/file_download_service.dart';

/// Simple service locator — creates the full dependency chain.
///
/// Call [setupServiceLocator] once in `main()` before `runApp()`.
class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator _instance = ServiceLocator._();
  static ServiceLocator get instance => _instance;

  // ── Core ────────────────────────────────────────────────────────────────────
  late final ApiClient apiClient;
  late final AuthRemoteDataSource authRemoteDataSource;
  late final AuthRepository authRepository;

  late final SplashRemoteDataSource splashRemoteDataSource;
  late final SplashRepository splashRepository;
  
  late final ProfileRemoteDataSource profileRemoteDataSource;
  late final ProfileRepository profileRepository;


  late final FileDownloadService fileDownloadService;

  // ── Use Cases ───────────────────────────────────────────────────────────────
  late final SignInUseCase signInUseCase;
  late final SignInWithGoogleUseCase signInWithGoogleUseCase;
  late final SignOutUseCase signOutUseCase;
  late final ForgotPasswordUseCase forgotPasswordUseCase;
  late final VerifyResetCodeUseCase verifyResetCodeUseCase;
  late final ResetPasswordUseCase resetPasswordUseCase;

  late final CheckAuthUseCase checkAuthUseCase;

  late final GetProfileUseCase getProfileUseCase;
  late final UpdateProfilePhotoUseCase updateProfilePhotoUseCase;
  late final UpdateProfileInfoUseCase updateProfileInfoUseCase;
  late final ChangePasswordUseCase changePasswordUseCase;
  late final DeleteAccountUseCase deleteAccountUseCase;

  // ── Blocs ───────────────────────────────────────────────────────────────────
  late final AuthBloc authBloc;
  late final SignUpBloc signUpBloc;
  late final ForgotPasswordBloc forgotPasswordBloc;
  late final ProfileBloc profileBloc;
  late final SplashBloc splashBloc;
  

  /// Initialise all dependencies.
  void init() {
    // Core
    apiClient = ApiClient();
    authRemoteDataSource = AuthRemoteDataSourceImpl(apiClient);
    authRepository = AuthRepositoryImpl(authRemoteDataSource);
    
    splashRemoteDataSource = SplashRemoteDataSourceImpl(apiClient);
    splashRepository = SplashRepositoryImpl(splashRemoteDataSource);
    
    profileRemoteDataSource = ProfileRemoteDataSourceImpl(apiClient);
    profileRepository = ProfileRepositoryImpl(profileRemoteDataSource);



    fileDownloadService = FileDownloadService(apiClient);

    // Use Cases
    signInUseCase = SignInUseCase(authRepository);
    signInWithGoogleUseCase = SignInWithGoogleUseCase(authRepository);
    signOutUseCase = SignOutUseCase(authRepository);
    forgotPasswordUseCase = ForgotPasswordUseCase(authRepository);
    verifyResetCodeUseCase = VerifyResetCodeUseCase(authRepository);
    resetPasswordUseCase = ResetPasswordUseCase(authRepository);
    
    checkAuthUseCase = CheckAuthUseCase(splashRepository);

    getProfileUseCase = GetProfileUseCase(profileRepository);
    updateProfilePhotoUseCase = UpdateProfilePhotoUseCase(profileRepository);
    updateProfileInfoUseCase = UpdateProfileInfoUseCase(profileRepository);
    changePasswordUseCase = ChangePasswordUseCase(profileRepository);
    deleteAccountUseCase = DeleteAccountUseCase(profileRepository);



    // Blocs
    authBloc = AuthBloc(
      signInUseCase: signInUseCase,
      signOutUseCase: signOutUseCase,
      signInWithGoogleUseCase: signInWithGoogleUseCase,
      remoteDataSource: authRemoteDataSource,
    );

    signUpBloc = SignUpBloc(
      authRepository: authRepository,
      remoteDataSource: authRemoteDataSource,
      authBlocSessionSetter: (session) {
        authBloc.add(AuthEvent.sessionSet(session: session));
      },
    );

    forgotPasswordBloc = ForgotPasswordBloc(
      forgotPasswordUseCase: forgotPasswordUseCase,
      verifyResetCodeUseCase: verifyResetCodeUseCase,
      resetPasswordUseCase: resetPasswordUseCase,
    );
    
    profileBloc = ProfileBloc(
      getProfileUseCase: getProfileUseCase,
      updateProfilePhotoUseCase: updateProfilePhotoUseCase,
      updateProfileInfoUseCase: updateProfileInfoUseCase,
    );

    splashBloc = SplashBloc(
      checkAuthUseCase: checkAuthUseCase,
      authRemoteDataSource: authRemoteDataSource,
    );

  }
}


/// Convenience function to call from `main()`.
void setupServiceLocator() {
  ServiceLocator.instance.init();
}
