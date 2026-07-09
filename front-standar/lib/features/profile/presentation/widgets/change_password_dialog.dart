import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/ui_kit/atoms/buttons/primary_button.dart';
import '../../../../core/ui_kit/atoms/inputs/custom_text_field.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';
import '../../../../core/ui_kit/feedback/app_toast.dart';
import '../../../../core/networking/exceptions/api_exception.dart';

Future<void> showChangePasswordDialog(BuildContext context, {bool hasPassword = true}) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ChangePasswordDialog(hasPassword: hasPassword),
  );
}

class ChangePasswordDialog extends StatefulWidget {
  final bool hasPassword;
  const ChangePasswordDialog({super.key, this.hasPassword = true});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      await ServiceLocator.instance.changePasswordUseCase(
        oldPassword: widget.hasPassword ? _currentPasswordController.text.trim() : null,
        newPassword: _newPasswordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      );

      if (!mounted) return;

      setState(() => _isLoading = false);
      Navigator.of(context).pop();
      AppToastHelper.success(
        context,
        widget.hasPassword
            ? 'Your password has been changed successfully.'
            : 'Your password has been created successfully.',
        title: widget.hasPassword ? 'Password Changed' : 'Password Created',
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      AppToastHelper.error(
        context,
        e.message,
        title: 'Error',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      AppToastHelper.error(
        context,
        'An unexpected error occurred.',
        title: 'Error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.textHint.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.textHint, width: 1),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                // Header row
                SizedBox(height: 15,),
                Text(
                  widget.hasPassword ? 'Change Password' : 'Create Password',
                  style: const TextStyle(
                    fontFamily: AppAssets.montserrat,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.hasPassword
                      ? 'Enter your current password and choose a new one.'
                      : 'Choose a password for your account.',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 28),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (widget.hasPassword) ...[
                        CustomTextField(
                          controller: _currentPasswordController,
                          label: 'Current Password',
                          hintText: 'Enter your current password',
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: true,
                          enabled: !_isLoading,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Current password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                      ],
                      CustomTextField(
                        controller: _newPasswordController,
                        label: widget.hasPassword ? 'New Password' : 'Password',
                        hintText: widget.hasPassword ? 'Enter new password' : 'Enter password',
                        prefixIcon: Icons.lock_rounded,
                        obscureText: true,
                        enabled: !_isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'New password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hintText: widget.hasPassword ? 'Re-enter your new password' : 'Re-enter your password',
                        prefixIcon: Icons.lock_rounded,
                        obscureText: true,
                        enabled: !_isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        label: widget.hasPassword ? 'Change Password' : 'Create Password',
                        isLoading: _isLoading,
                        onTap: _isLoading ? null : _submit,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
