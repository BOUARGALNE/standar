import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../../../core/ui_kit/atoms/buttons/primary_button.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/feedback/app_toast.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';
import '../bloc/sign_up_bloc.dart';
import 'personal_info_footer.dart';
import 'personal_info_form.dart';
import 'terms_checkbox.dart';
import '../../../../core/ui_kit/organisms/step_headline.dart';

/// Step 1 of the Sign Up flow — account creation form.
///
/// Collects: Full Name, Email, Phone, Password, Confirm Password, Terms.
/// On valid submit, saves data via [SignUpFormDataNotifier] and calls [onNext].
class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({
    super.key,
    required this.initialData,
    required this.onNext,
    required this.onSignIn,
  });

  final SignUpFormData initialData;

  /// Called with captured form data when the user taps "Create Account".
  final void Function({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required bool acceptTerms,
    required String country,
  })
  onNext;

  /// Called when the user taps "Sign In".
  final VoidCallback onSignIn;

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool _acceptTerms = false;
  bool _isLoading = false;
  String _dialCode = '1'; // default US
  String _countryName = 'United States'; // default US

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialData.firstName);
    _lastNameController = TextEditingController(text: widget.initialData.lastName);
    _emailController = TextEditingController(text: widget.initialData.email);
    
    // Extract phone without dial code if possible, or just set it
    // Note: since we prepend dial code in onNext, we might want to just set it as is
    // For simplicity, we just set the phone. In a real app, parse the dial code out.
    // Here we'll just set it. If it has '+1', we could strip it, but it's fine for now.
    String initialPhone = widget.initialData.phone;
    if (initialPhone.startsWith('+')) {
      // Find the first matching country or just strip the '+' for now
      // A more robust solution requires libphonenumber, but for UI sake:
      // We'll leave it as is, or strip if we know the dial code
      // We will assume the user has to re-select if they go back and want to change
    }
    _phoneController = TextEditingController(text: widget.initialData.phone.replaceFirst(RegExp(r'^\+\d+'), ''));
    
    _passwordController = TextEditingController(text: widget.initialData.password);
    _confirmPasswordController = TextEditingController(text: widget.initialData.password);
    _acceptTerms = widget.initialData.acceptTerms;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_acceptTerms) {
      AppToastHelper.error(
        context,
        'Please accept the Terms of Service to continue.',
        title: 'Required',
      );
      return;
    }

    setState(() => _isLoading = true);

    // Full phone with dial code
    final phone = '+$_dialCode${_phoneController.text.trim()}';

    widget.onNext(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: phone,
      password: _passwordController.text,
      acceptTerms: _acceptTerms,
      country: _countryName,
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveWidth(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Headline
                  Padding(
                    padding: EdgeInsets.only(top: context.screenHeight*0.07,bottom: context.screenHeight*0.03),
                    child: const StepHeadline(
                      title: 'Join ',
                      accentPart: 'Siwl.',
                      description:
                          'Create an account to start experiencing\nmagnetic connections.',
                    ),
                  ),
                  // Form fields
                  Form(
                    key: _formKey,
                    child: PersonalInfoForm(
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      passwordRef: _passwordController,
                      isLoading: _isLoading,
                      onCountryChanged: (Country country) {
                        _dialCode = country.phoneCode;
                        _countryName = country.name;
                      },
                    ),
                  ),

                  SizedBox(height: context.responsiveHeight(20)),

                  // Terms checkbox
                  TermsCheckbox(
                    value: _acceptTerms,
                    onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                    onTermsTap: () {
                      // TODO: open Terms of Service
                    },
                    onPrivacyTap: () {
                      // TODO: open Privacy Policy
                    },
                  ),

                  SizedBox(height: context.responsiveHeight(28)),

                  // Create Account button
                  PrimaryButton(
                    label: 'Create Account',
                    isLoading: _isLoading,
                    onTap: _isLoading ? null : _handleNext,
                    suffixIcon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.textOnPrimary,
                      size: 18,
                    ),
                  ),

                  SizedBox(height: context.responsiveHeight(20)),

                  // "Already a member? Sign In"
                  PersonalInfoFooter(onSignIn: widget.onSignIn),

                  SizedBox(height: context.responsiveHeight(24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

