import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/networking/client/dio_client.dart';
import '../../../../core/networking/exceptions/api_exception.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/services/token_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

// ─── Form data ───────────────────────────────────────────────────────────────

/// Form data model for the multi-step signup flow.
class SignUpFormData {
  SignUpFormData({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.acceptTerms = false,
    this.country = '',
  });

  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  bool acceptTerms;
  String country;

  SignUpFormData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    bool? acceptTerms,
    String? country,
  }) {
    return SignUpFormData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      country: country ?? this.country,
    );
  }
}

// ─── Bloc ────────────────────────────────────────────────────────────────────

/// Callback type used by [SignUpBloc] to set the session on [AuthBloc]
/// without a direct dependency.
typedef AuthBlocSessionSetter = void Function(AuthSession session);

/// Bloc for the multi-step sign-up flow.
///
/// Follows the proper Bloc pattern with Event → State.
/// Manages both the form data and the signup state.
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthRepository authRepository,
    required AuthRemoteDataSource remoteDataSource,
    required AuthBlocSessionSetter authBlocSessionSetter,
  })  : _authRepository = authRepository,
        _remoteDataSource = remoteDataSource,
        _authBlocSessionSetter = authBlocSessionSetter,
        super(const SignUpState.initial()) {
    on<SignUpFormDataUpdated>(_onFormDataUpdated);
    on<SignUpFieldUpdated>(_onFieldUpdated);
    on<SignUpVerificationCodeSendRequested>(_onVerificationCodeSendRequested);
    on<SignUpCodeVerifyRequested>(_onCodeVerifyRequested);
    on<SignUpRegisterRequested>(_onRegisterRequested);
    on<SignUpResetRequested>(_onResetRequested);
  }

  final AuthRepository _authRepository;
  final AuthRemoteDataSource _remoteDataSource;
  final AuthBlocSessionSetter _authBlocSessionSetter;

  /// Mutable form data — managed internally by the bloc.
  SignUpFormData _formData = SignUpFormData();

  /// Read-only access to current form data.
  SignUpFormData get formData => _formData;

  /// Get error message if in failure state
  String? get errorMessage {
    return state.mapOrNull(failure: (s) => s.message);
  }

  // ── Event handlers ─────────────────────────────────────────────────────────

  void _onFormDataUpdated(
    SignUpFormDataUpdated event,
    Emitter<SignUpState> emit,
  ) {
    _formData = event.formData;
  }

  void _onFieldUpdated(
    SignUpFieldUpdated event,
    Emitter<SignUpState> emit,
  ) {
    _formData = _formData.copyWith(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      phone: event.phone,
      password: event.password,
      acceptTerms: event.acceptTerms,
      country: event.country,
    );
  }

  Future<void> _onVerificationCodeSendRequested(
    SignUpVerificationCodeSendRequested event,
    Emitter<SignUpState> emit,
  ) async {
    final target =_formData.email;

    emit(const SignUpState.loading(
      action: SignUpLoadingAction.sendingCode,
      message: 'Envoi du code...',
    ));

    try {
      bool success;
      success = await _authRepository.sendEmailVerificationCode(target);
      if (success) {
        emit(SignUpState.verificationCodeSent(
          message: 'Code envoyé à $target',
        ));
      } else {
        emit(const SignUpState.failure(message: 'Échec de l\'envoi du code'));
      }
    } on ApiException catch (e) {
      emit(SignUpState.failure(message: e.message));
    } catch (e) {
      emit(SignUpState.failure(message: e.toString()));
    }
  }

  Future<void> _onCodeVerifyRequested(
    SignUpCodeVerifyRequested event,
    Emitter<SignUpState> emit,
  ) async {
    final target =  _formData.email ;

    emit(const SignUpState.loading(
      action: SignUpLoadingAction.verifyingCode,
      message: 'Vérification du code...',
    ));

    try {
      await _authRepository.verifyEmailCode(target, event.code);

      emit(const SignUpState.verificationCodeVerified());
    } on ApiException catch (e) {
      emit(SignUpState.failure(message: e.message));
    } catch (e) {
      emit(SignUpState.failure(message: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    SignUpRegisterRequested event,
    Emitter<SignUpState> emit,
  ) async {
    final data = _formData;

    emit(const SignUpState.loading(
      action: SignUpLoadingAction.registering,
      message: 'Inscription en cours...',
    ));

    try {
      final session = await _authRepository.register(
        firstName: data.firstName.trim(),
        lastName: data.lastName.trim(),
        phone: data.phone,
        email: data.email,
        password: data.password,
        country: data.country,
      );

      // Set the auth token in DioClient
      DioClient.instance.setAuthToken(session.token);

      // Save tokens for persistence and refresh
      await TokenService.instance.saveTokens(
        userId: session.userId,
        accessToken: session.token,
        refreshToken: session.refreshToken,
      );

      // Initialize refresh mechanism
      TokenService.instance.initialize(
        dataSource: _remoteDataSource,
        onSessionExpired: () {
          add(const SignUpEvent.resetRequested());
        },
      );

      emit(SignUpState.success(session: session));
      // Update the AuthBloc with the new session
      _authBlocSessionSetter(session);
    } on ApiException catch (e) {
      emit(SignUpState.failure(message: e.message));
    } catch (e) {
      emit(SignUpState.failure(message: e.toString()));
    }
  }

  void _onResetRequested(
    SignUpResetRequested event,
    Emitter<SignUpState> emit,
  ) {
    _formData = SignUpFormData();
    emit(const SignUpState.initial());
  }
}
