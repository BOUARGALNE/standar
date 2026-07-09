import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siwl/core/networking/endpoints/api_endpoints.dart';
import 'package:siwl/core/ui_kit/atoms/buttons/simple_button.dart';
import 'package:siwl/core/ui_kit/theme/app_colors.dart';
import 'package:siwl/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:siwl/features/profile/presentation/widgets/settings_item.dart';
import 'package:siwl/features/profile/presentation/widgets/personal_info_dialog.dart';
import 'package:siwl/core/di/service_locator.dart';
import 'package:siwl/core/networking/exceptions/api_exception.dart';
import 'package:siwl/core/ui_kit/feedback/app_toast.dart';
import 'package:siwl/core/ui_kit/feedback/confirmation_dialog.dart';
import 'package:siwl/features/profile/presentation/widgets/change_password_dialog.dart';
import 'package:siwl/core/ui_kit/feedback/custom_refresh.dart';
import 'package:go_router/go_router.dart';
import 'package:siwl/core/navigation/app_routes.dart';
import 'package:siwl/features/auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isDeletingAccount = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(const ProfileEvent.fetchRequested());
    });
  }

  Future<void> _pickAndUploadImage(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && context.mounted) {
        context.read<ProfileBloc>().add(
          ProfileEvent.photoUpdateRequested(File(image.path)),
        );
      }
    } catch (e) {
      // Handle error gracefully if needed
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _deleteAccount() async {
    final bool? confirmed = await showConfirmationDialog(
      context: context,
      title: 'Delete Account',
      message: 'Are you sure you want to delete your account? This action is permanent and cannot be undone.',
      confirmText: 'Delete',
      isDestructive: true,
    );

    if (confirmed != true) return;

    setState(() => _isDeletingAccount = true);

    try {
      await ServiceLocator.instance.deleteAccountUseCase();
      if (!mounted) return;
      context.read<AuthBloc>().add(const AuthEvent.signOutRequested());
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _isDeletingAccount = false);
      AppToastHelper.error(context, e.message, title: 'Error');
    } catch (e) {
      if (!mounted) return;
      setState(() => _isDeletingAccount = false);
      AppToastHelper.error(context, 'An unexpected error occurred.', title: 'Error');
    }
  }

  Future<void> _logout() async {
    final bool? confirmed = await showConfirmationDialog(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to log out from your account?',
      confirmText: 'Logout',
      isDestructive: true,
    );

    if (confirmed == true) {
      if (!mounted) return;
      context.read<AuthBloc>().add(const AuthEvent.signOutRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
          success: (user) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar with Edit Button
                ProfileAvatar(
                  imageUrl: (user.avatar!.startsWith('http')
                          ? user.avatar! 
                          : '${ApiEndpoints.baseUrl.replaceAll('/api/', '/')}${user.avatar!.startsWith('/') ? user.avatar!.substring(1) : user.avatar!}'),
                  onEditTap: () => _pickAndUploadImage(context),
                ),
                const SizedBox(height: 24),

                // Name and Email
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),

                // Settings List
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: Icons.person_outline,
                        iconColor: AppColors.primary,
                        iconBackgroundColor: AppColors.primaryLight3,
                        title: 'Personal Information',
                        onTap: () {
                          showPersonalInfoDialog(context, user);
                        },
                      ),
                      Divider(height: 1, color: Colors.grey.withValues(alpha: 0.1)),
                      SettingsItem(
                        icon: Icons.shield_outlined,
                        iconColor: AppColors.primary,
                        iconBackgroundColor: AppColors.primaryLight3,
                        title: user.hasPassword ? 'Change Password' : 'Create Password',
                        onTap: () {
                          showChangePasswordDialog(context, hasPassword: user.hasPassword);
                        },
                      ),
                      Divider(height: 1, color: Colors.grey.withValues(alpha: 0.1)),
                      SettingsItem(
                        icon: Icons.help_outline,
                        iconColor: AppColors.primary,
                        iconBackgroundColor: AppColors.primaryLight3,
                        title: 'FAQ',
                        onTap: () => context.push(AppRoutes.faq),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SimpleButton(
                  text: "Logout",
                  textColor: AppColors.red,
                  backgroundColor: AppColors.red.withValues(alpha: 0.02),
                  borderRadius: 12,
                  isFilled: true,
                  borderColor: AppColors.red.withValues(alpha: 0.5),
                  onPressed: _logout,
                  prefixIcon: const Icon(
                    Icons.logout,
                    color: AppColors.red,
                    size: 20,
                  ),
                ),

                const SizedBox(height: 20),
                SimpleButton(
                  text: "Delete account",
                  textColor: AppColors.textHint,
                  borderColor: AppColors.transparent,
                  isLoading: _isDeletingAccount,
                  onPressed: _deleteAccount,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          failure: (message) => CustomRefresh(
            description: message,
            onRefresh: () {
              context.read<ProfileBloc>().add(const ProfileEvent.fetchRequested());
            },
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
