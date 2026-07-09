import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui_kit/atoms/inputs/custom_text_field.dart';
import '../../../../core/ui_kit/atoms/inputs/phone_text_field.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/utils/validators/email_validator.dart';
import '../../../../core/utils/validators/password_validator.dart';
import '../../../../core/utils/validators/phone_validator.dart';


/// The input fields for the PersonalInfoStep.
///
/// Full Name, Email, Phone, Password, Confirm Password.
class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.passwordRef,
    this.onCountryChanged,
    this.isLoading = false,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  /// Reference to the password controller used for confirm-password validation.
  final TextEditingController passwordRef;

  /// Called when the user picks a different country in the phone field.
  final ValueChanged<Country>? onCountryChanged;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full Name
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: firstNameController,
                label: 'First Name',
                hintText: 'first name',
                autocorrect: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                enabled: !isLoading,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'first name required';
                  return null;
                },
              ),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: CustomTextField(
                controller: lastNameController,
                label: 'Last Name',
                hintText: 'last name',
                autocorrect: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                enabled: !isLoading,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'last name required';
                  return null;
                },
              ),
            ),
          ],
        ),


        SizedBox(height: context.responsiveHeight(16)),

        // Email
        CustomTextField(
          controller: emailController,
          label: 'Email',
          hintText: 'Enter your email',
          suffixIcon: Icons.alternate_email_rounded,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enabled: !isLoading,
          validator: (v) => EmailValidator.validate(
            v,
            emptyMessage: 'Please enter your email',
            invalidMessage: 'Enter a valid email address',
          ),
        ),

        SizedBox(height: context.responsiveHeight(16)),

        // Phone
        PhoneTextField(
          controller: phoneController,
          label: 'Phone Number',
          hintText: '6XXXXXXXXX',
          initialCountryCode: 'US',
          enabled: !isLoading,
          onCountryChanged: onCountryChanged,
          textInputAction: TextInputAction.next,
          validator: (v) => PhoneValidator.validate(v),
        ),

        SizedBox(height: context.responsiveHeight(16)),
        // Password
        CustomTextField(
          controller: passwordController,
          label: 'Password',
          hintText: '••••••••',
          suffixIcon: Icons.lock_outline_rounded,
          obscureText: true,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enabled: !isLoading,
          validator: (v) => PasswordValidator.validate(v),
        ),

        SizedBox(height: context.responsiveHeight(16)),

        // Confirm Password
        CustomTextField(
          controller: confirmPasswordController,
          label: 'Confirm Password',
          hintText: '••••••••',
          suffixIcon: Icons.check_circle_outline_rounded,
          obscureText: true,
          textInputAction: TextInputAction.done,
          autocorrect: false,
          enabled: !isLoading,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Please confirm your password';
            if (v != passwordRef.text) return 'Passwords do not match';
            return null;
          },
        ),
      ],
    );
  }
}
