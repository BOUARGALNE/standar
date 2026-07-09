import 'dart:io';

import '../../../../core/networking/client/api_client.dart';
import '../../../../core/networking/endpoints/api_endpoints.dart';
import '../../../../core/networking/exceptions/api_exception.dart';
import '../models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile();
  Future<void> updateProfilePhoto(File file);
  Future<UserModel> updateProfileInfo({
    String? firstName,
    String? lastName,
    String? phone,
    String? country,
  });
  Future<void> changePassword({
    String? oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<void> deleteAccount();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<UserModel> getProfile() async {
    final response = await _apiClient.get<UserModel>(
      ApiEndpoints.getProfile,
      fromJson: (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );

    if (response.success && response.data != null) {
      return response.data!;
    }

    throw ApiException.unknown(
      message: response.error ?? 'Failed to fetch profile',
    );
  }

  @override
  Future<void> updateProfilePhoto(File file) async {
    final response = await _apiClient.uploadFile<dynamic>(
      ApiEndpoints.profileAvatar,
      filePath: file.path,
      fieldName: 'file',
    );

    if (!response.success) {
      throw ApiException.unknown(
        message: response.error ?? 'Failed to upload profile photo',
      );
    }
  }

  @override
  Future<UserModel> updateProfileInfo({
    String? firstName,
    String? lastName,
    String? phone,
    String? country,
  }) async {
    final Map<String, dynamic> data = {};
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (phone != null) data['phone'] = phone;
    if (country != null) data['country'] = country;

    final response = await _apiClient.put<UserModel>(
      ApiEndpoints.updateProfileInfo,
      data: data,
      fromJson: (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );

    if (response.success && response.data != null) {
      return response.data!;
    }

    throw ApiException.unknown(
      message: response.error ?? 'Failed to update profile info',
    );
  }

  @override
  Future<void> changePassword({
    String? oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final Map<String, dynamic> data = {
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
    if (oldPassword != null) {
      data['old_password'] = oldPassword;
    }

    final response = await _apiClient.put<dynamic>(
      ApiEndpoints.changePassword,
      data: data,
    );

    if (!response.success) {
      throw ApiException.unknown(
        message: response.error ?? 'Failed to change password',
      );
    }
  }

  @override
  Future<void> deleteAccount() async {
    final response = await _apiClient.delete<dynamic>(
      ApiEndpoints.deleteAccount,
      fromJson: (_) {},
    );

    if (!response.success) {
      throw ApiException.unknown(
        message: response.error ?? 'Failed to delete account',
      );
    }
  }
}
