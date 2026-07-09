import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/ui_kit/feedback/app_toast.dart';
import '../bloc/sign_up_bloc.dart';
import '../widgets/personal_info_step.dart';
import '../widgets/email_verification_step.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  static const int _totalSteps = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ── Navigation ─────────────────────────────────────────────────────────────

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    } else {
      context.go('/login');
    }
  }

  // ── Handlers ───────────────────────────────────────────────────────────────

  void _onPersonalInfoNext({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required bool acceptTerms,
    required String country,
  }) {
    final currentFormData = context.read<SignUpBloc>().formData;
    context.read<SignUpBloc>().add(SignUpEvent.formDataUpdated(
          formData: currentFormData.copyWith(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            password: password,
            acceptTerms: acceptTerms,
            country: country,
          ),
        ));
    _nextStep();
  }

  Future<bool> _onVerifyCode(String code) async {
    final bloc = context.read<SignUpBloc>();

    bloc.add(SignUpEvent.codeVerifyRequested(code: code));

    // Wait for state change
    final state = await bloc.stream.firstWhere(
      (s) => s is! SignUpLoading,
    );

    if (!mounted) return false;

    if (state is SignUpVerificationCodeVerified) {
      AppToastHelper.success(context, 'Email verified!');
      return true;
    } else if (state is SignUpFailure) {
      AppToastHelper.error(context, state.message);
      return false;
    }

    return false;
  }

  Future<void> _onResendCode() async {
    final bloc = context.read<SignUpBloc>();
    bloc.add(const SignUpEvent.verificationCodeSendRequested());

    final state = await bloc.stream.firstWhere(
      (s) => s is! SignUpLoading,
    );

    if (!mounted) return;

    if (state is SignUpVerificationCodeSent) {
      AppToastHelper.success(context, 'Code resent successfully');
    } else if (state is SignUpFailure) {
      AppToastHelper.error(context, state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (session) {
            AppToastHelper.success(context, 'Sign up successful!');
            context.goNamed('editor'); // navigate to the main flow
          },
          failure: (message) {
            AppToastHelper.error(context, message);
          },
        );
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, signUpState) {
          final isLoading = signUpState.isLoading;
          final email = context.read<SignUpBloc>().formData.email;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => setState(() => _currentStep = index),
              children: [
                // ── Step 0: Personal Info ──────────────────────────────────
                PersonalInfoStep(
                  initialData: context.read<SignUpBloc>().formData,
                  onNext: _onPersonalInfoNext,
                  onSignIn: () => context.go('/login'),
                ),

                EmailVerificationStep(
                  email: email,
                  onBack: _previousStep,
                  onVerified: (){
                    context.read<SignUpBloc>().add(const SignUpEvent.registerRequested());
                    },
                  isLoading: isLoading,
                  onVerifyCode: _onVerifyCode,
                  onResendCode: _onResendCode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
