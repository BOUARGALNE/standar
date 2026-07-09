import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/ui_kit/atoms/buttons/primary_button.dart';
import '../../../../core/ui_kit/atoms/inputs/custom_text_field.dart';
import '../../../../core/ui_kit/theme/app_colors.dart';
import '../../../../core/ui_kit/extensions/context_extensions.dart';
import '../../../../core/ui_kit/feedback/app_toast.dart';
import '../../../../core/networking/exceptions/api_exception.dart';
import '../../../../core/ui_kit/atoms/inputs/phone_text_field.dart';
import 'package:country_picker/country_picker.dart';
import '../bloc/profile_bloc.dart';

Future<void> showPersonalInfoDialog(BuildContext context, User user) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: context.read<ProfileBloc>(),
      child: PersonalInfoDialog(user: user),
    ),
  );
}

class PersonalInfoDialog extends StatefulWidget {
  final User user;

  const PersonalInfoDialog({super.key, required this.user});

  @override
  State<PersonalInfoDialog> createState() => _PersonalInfoDialogState();
}

class _PersonalInfoDialogState extends State<PersonalInfoDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _countryController;

  bool _isEditing = false;
  bool _isLoading = false;

  late String _selectedDialCode;
  late String _initialCountryCode;
  String? _selectedCountryName;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
    
    String parsedPhone = widget.user.phone ?? '';
    _initialCountryCode = 'US';
    _selectedDialCode = '1';
    
    if (parsedPhone.startsWith('+')) {
      if (parsedPhone.startsWith('+212')) {
        _initialCountryCode = 'MA';
        _selectedDialCode = '212';
        _selectedCountryName = 'Morocco';
        parsedPhone = parsedPhone.substring(4);
      } else {
        final countries = List<Country>.from(CountryService().getAll());
        countries.sort((a, b) => b.phoneCode.length.compareTo(a.phoneCode.length));
        for (final country in countries) {
          if (parsedPhone.startsWith('+${country.phoneCode}')) {
            _initialCountryCode = country.countryCode;
            _selectedDialCode = country.phoneCode;
            _selectedCountryName = country.name;
            parsedPhone = parsedPhone.substring(country.phoneCode.length + 1);
            break;
          }
        }
      }
    }
    
    _phoneController = TextEditingController(text: parsedPhone);
    _countryController = TextEditingController(text: widget.user.country ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _saveInfo() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    final bloc = context.read<ProfileBloc>();
    bloc.add(ProfileEvent.infoUpdateRequested(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phone: _phoneController.text.trim().isEmpty ? null : '+$_selectedDialCode${_phoneController.text.trim()}',
      country: _selectedCountryName,
    ));

    try {
      final resultState = await bloc.stream.firstWhere(
        (s) => s is ProfileSuccess || s is ProfileFailure,
      );

      if (!mounted) return;

      if (resultState is ProfileSuccess) {
        setState(() {
          _isLoading = false;
          _isEditing = false;
        });
        AppToastHelper.success(
          context,
          'Your personal information has been updated.',
          title: 'Success',
        );
      } else if (resultState is ProfileFailure) {
        setState(() => _isLoading = false);
        AppToastHelper.error(
          context,
          resultState.message,
          title: 'Error',
        );
      }
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
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.textHint.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!_isEditing)
                        GestureDetector(
                          onTap: () => setState(() => _isEditing = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.edit_outlined, size: 14, color: AppColors.white),
                                const SizedBox(width: 4),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontSize: context.responsiveFontSize(12),
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      GestureDetector(
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
                    ],
                  ),
                ),
                // Header
                SizedBox(height: 15,),
                const Text(
                  'Personal Info',
                  style: TextStyle(
                    fontFamily: AppAssets.montserrat,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 6),
                Text(
                  _isEditing
                      ? 'Update your personal details below.'
                      : 'View your personal details.',
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
                      CustomTextField(
                        controller: _firstNameController,
                        label: 'First Name',
                        prefixIcon: Icons.person_outline,
                        readOnly: !_isEditing,
                        enabled: !_isLoading,
                        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        prefixIcon: Icons.person_outline,
                        readOnly: !_isEditing,
                        enabled: !_isLoading,
                        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        prefixIcon: Icons.email_outlined,
                        readOnly: true, // Email is not editable
                        enabled: !_isEditing,
                      ),
                      const SizedBox(height: 18),
                      PhoneTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        readOnly: !_isEditing,
                        enabled: !_isLoading,
                        initialCountryCode: _initialCountryCode,
                        onCountryChanged: (country) {
                          _selectedDialCode = country.phoneCode;
                          _selectedCountryName = country.name;
                        },
                      ),
                      SizedBox(height: context.screenHeight*0.07),

                      if (_isEditing) ...[
                        PrimaryButton(
                          label: 'Save Changes',
                          isLoading: _isLoading,
                          onTap: _isLoading ? null : _saveInfo,
                        ),
                      ],
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
