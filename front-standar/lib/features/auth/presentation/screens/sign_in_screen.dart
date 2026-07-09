import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/ui_kit/atoms/buttons/primary_button.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/feedback/app_toast.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/sign_in_footer.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/sign_in_header.dart';
import '../widgets/forgot_password_dialog.dart';
import '../widgets/sign_in_social_section.dart';

/// Sign In Screen — Velvet Pulse
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController(text: "bouargalne.hamid@gmail.com");
  final _passwordController = TextEditingController(text: "Hamid@1234");
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(AuthEvent.signInRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (session) => context.goNamed('editor'),
          failure: (message) =>
              AppToastHelper.error(context, message, title: 'Login failed'),
        );
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final isLoading = authState is AuthLoading;

          return Scaffold(
            backgroundColor: AppColors.background,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height: context.screenHeight,
                child: Column(
                  children: [
                    // ── Top area: logo + headline ─────────────────────────
                    Padding(
                      padding: EdgeInsets.only(
                        left: context.responsiveWidth(24),
                        right: context.responsiveWidth(24),
                        top: context.responsiveHeight(100),
                        bottom: context.responsiveHeight(40),
                      ),
                      child: const SignInHeader(),
                    ),

                    // ── Bottom card: form + actions ────────────────────────
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Form fields
                              SignInForm(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                isLoading: isLoading,
                                onForgotPassword: () {
                                  showForgotPasswordDialog(context);
                                },
                              ),

                              SizedBox(height: context.responsiveHeight(28)),

                              // Login button
                              PrimaryButton(
                                height: 55,
                                label: 'Sign In',
                                isLoading: isLoading,
                                onTap: isLoading ? null : _handleSignIn,
                              ),

                              SizedBox(height: context.responsiveHeight(40)),

                              // Social login
                              SignInSocialSection(
                                isLoading: isLoading,
                                onGoogleTap: () {
                                  context.read<AuthBloc>().add(
                                    const AuthEvent.googleSignInRequested(),
                                  );
                                },
                                onAppleTap: () {
                                  // TODO: Apple sign in
                                },
                              ),
                              // Footer link
                              SizedBox(height: context.responsiveHeight(20)),
                              SignInFooter(
                                isLoading: isLoading,
                                onSignUpTap: () {
                                  AppRouter.router.pushNamed('register');
                                },
                              ),

                              SizedBox(height: context.responsiveHeight(16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
